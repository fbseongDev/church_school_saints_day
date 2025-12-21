import 'package:church_school_saints_day/slide.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';

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
    final isFullscreen = useState<bool>(false);
    final focusNode = useFocusNode();

    useEffect(() {
      DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
        if (call.method == 'update') {
          value.value = call.arguments as int;
        }
      });
      return null;
    }, const []);

    final slides = Slide.values;
    void toggleFullscreen() {
      isFullscreen.value = !isFullscreen.value;
      if (isFullscreen.value) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    }
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKey: (event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyF) {
          toggleFullscreen();
        }
      },
      child: Material(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned.fill(
              child: Image(
                image: slides[value.value.clamp(0, slides.length - 1)].screen,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
              child: Text(
                slides[value.value.clamp(0, slides.length - 1)].name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width/13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}