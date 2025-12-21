import 'dart:developer' as dev;
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
    final focusNode = useFocusNode(debugLabel: 'display-keyboard-focus');

    useEffect(() {
      dev.log('useEffect mounted: DisplayPage', name: 'Display');
      DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
        dev.log(
          'MethodHandler called: method=${call.method}, args=${call.arguments}, fromWindowId=$fromWindowId',
          name: 'Display',
        );
        if (call.method == 'update') {
          value.value = call.arguments as int;
        }
      });
      return null;
    }, const []);

    final slides = Slide.values;
    void toggleFullscreen() {
      isFullscreen.value = !isFullscreen.value;
      dev.log(
        'toggleFullscreen called -> isFullscreen=${isFullscreen.value}',
        name: 'Display',
      );
      try {
        if (isFullscreen.value) {
          dev.log('Setting SystemUiMode.immersiveSticky', name: 'Display');
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        } else {
          dev.log('Setting SystemUiMode.edgeToEdge', name: 'Display');
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        }
      } catch (e, s) {
        dev.log(
          'SystemChrome error: $e',
          name: 'Display',
          stackTrace: s,
          level: 1000,
        );
      }
    }
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onFocusChange: (hasFocus) {
        dev.log('RawKeyboardListener focus changed: $hasFocus', name: 'Display');
      },
      onKey: (event) {
        dev.log(
          'Key event: runtimeType=${event.runtimeType}, logicalKey=${event.logicalKey}, keyLabel=${event.logicalKey.keyLabel}',
          name: 'Display',
        );
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyF) {
          dev.log('F key detected -> toggling fullscreen', name: 'Display');
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