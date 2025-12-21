import 'dart:async';
import 'package:church_school_saints_day/audio_manager.dart';
import 'package:church_school_saints_day/colors.dart';
import 'package:church_school_saints_day/flex_box_view.dart';
import 'package:church_school_saints_day/models/music.dart';
import 'package:church_school_saints_day/slide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'display_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

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

    final volume = useState(1.0);

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
            audioManger.dispose();

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
      backgroundColor: Colors.darkGrey,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: 32),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                '${counter + 1}. ${currentSlide.name}',
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '배경음',
                        style: TextStyle(
                          color: Colors.grey,
                          height: 1,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.darkGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    child: currentSlide.backgrounds.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(minHeight: 24),
                              child: Text(
                                '배경음이 없습니다',
                                style: TextStyle(color: Colors.grey, height: 1),
                              ),
                            ),
                          )
                        : FlexBoxView.builder(
                            spacing: 5,
                            runSpacing: 5,
                            itemBuilder: (_, index) {
                              return Column(
                                key: ValueKey('$counter-1-$index'),
                                children: [
                                  _audioBtn(
                                    music: currentSlide.backgrounds[index],
                                  ),
                                ],
                              );
                            },
                            itemCount: currentSlide.backgrounds.length,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(5),
              child: Slider(
                value: volume.value,
                min: 0.0,
                max: 1.0,
                inactiveColor: Colors.darkGrey,
                activeColor: Colors.grey,
                onChanged: (value) {
                  volume.value = value;
                  audioManger.setAllVolume(value);
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '효과음',
                        style: TextStyle(
                          color: Colors.grey,
                          height: 1,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.darkGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    child: currentSlide.effects.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(minHeight: 24),
                              child: Text(
                                '효과음이 없습니다',
                                style: TextStyle(color: Colors.grey, height: 1),
                              ),
                            ),
                          )
                        : FlexBoxView.builder(
                            spacing: 5,
                            runSpacing: 5,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                key: ValueKey('$counter-2-$index'),
                                child: _audioBtn(
                                  music: currentSlide.effects[index],
                                ),
                              );
                            },
                            itemCount: currentSlide.effects.length,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              spacing: 5,
              children: [
                if (counter > 0)
                  _screenBtn(CupertinoIcons.chevron_left, () {
                    volume.value = 1.0;

                    context.read<CounterState>().add(-1);
                  }),
                if (counter < Slide.values.length - 1)
                  _screenBtn(CupertinoIcons.chevron_right, () {
                    volume.value = 1.0;

                    context.read<CounterState>().add(1);
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _screenBtn(IconData icon, VoidCallback onTap) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24),
          backgroundColor: Colors.lightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          overlayColor: Colors.white,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _audioBtn({required Music music}) {
    return HookBuilder(
      builder: (context) {
        final isPlaying = useState(false);

        return GestureDetector(
          onTap: () async {
            if (isPlaying.value) {
              isPlaying.value = false;
              await audioManger.stop(music);
              return;
            }
            isPlaying.value = true;
            await audioManger.playAsset(music);
          },

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.lightGrey,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  music.name,
                  style: TextStyle(color: Colors.white, height: 1),
                ),
                if (isPlaying.value)
                  Icon(Icons.pause, color: Colors.white)
                else
                  Icon(Icons.play_arrow, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}

