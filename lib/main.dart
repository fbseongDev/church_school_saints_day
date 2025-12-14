import 'dart:async';
import 'package:church_school_saints_day/assets/musics/background_musics.dart';
import 'package:church_school_saints_day/audio_manager.dart';
import 'package:church_school_saints_day/slide.dart';
import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main(List<String> args) {
  if (args.isNotEmpty) {
    // 두 번째 창
    runApp(const DisplayApp());
  } else {
    // 첫 번째 창
    runApp(const ControllerApp());
  }
}

// -------------------- 상태 --------------------
class CounterState extends ChangeNotifier {
  int value = 0;

  void add(int delta) {
    value += delta;
    notifyListeners();
  }
}

// -------------------- 1번 창 --------------------
class ControllerApp extends StatelessWidget {
  const ControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterState(),
      child: MaterialApp(home: const ControllerPage()),
    );
  }
}

final audioManger = AudioManager();

class ControllerPage extends HookWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final windowId = useState<int?>(null);

    final counter = context.watch<CounterState>().value;

    final currentSlide = Slide.values[counter];

    useEffect(() {
      Future<void> openSecondWindow() async {
        final window = await DesktopMultiWindow.createWindow('display');
        window
          ..setTitle('Display Window')
          ..setFrame(const Offset(500, 200) & const Size(800, 450))
          ..show();

        windowId.value = window.windowId;

        context.read<CounterState>().addListener(() {
          if (windowId.value != null) {
            DesktopMultiWindow.invokeMethod(
              windowId.value!,
              'update',
              context.read<CounterState>().value,
            );
          }
        });
      }

      openSecondWindow();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: const Text('Controller')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(currentSlide.name, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            children: [
              if (counter > 0)
                _btn('이전', () => context.read<CounterState>().add(-1)),
              if (counter < Slide.values.length - 1)
                _btn('다음', () => context.read<CounterState>().add(1)),
            ],
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () async {
                    audioManger.playAsset(currentSlide.musics[index].path);
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.green,
                      child: Text(currentSlide.musics[index].name),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(width: 5);
              },
              itemCount: currentSlide.musics.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(String text, VoidCallback onTap) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }
}

// -------------------- 2번 창 --------------------
class DisplayApp extends StatelessWidget {
  const DisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const DisplayPage());
  }
}

class DisplayPage extends HookWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final value = useState<int>(0);

    useEffect(() {
      DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
        if (call.method == 'update') {
          value.value = call.arguments as int;
        }
      });
      return null;
    }, const []);

    final slides = Slide.values;

    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [

          Image(
            image: slides[value.value.clamp(0, slides.length - 1)].screen,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
            child: Text(
              slides[value.value.clamp(0, slides.length - 1)].name,
              style: TextStyle(fontSize: 52, fontWeight: FontWeight.w700,color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
