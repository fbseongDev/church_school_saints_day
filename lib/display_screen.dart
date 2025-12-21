import 'dart:developer' as dev;
import 'package:church_school_saints_day/slide.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

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

    useEffect(() {
      () async {
        dev.log('Initializing window_manager', name: 'Display');
        await windowManager.ensureInitialized();
        await windowManager.setPreventClose(true);
        await windowManager.setSkipTaskbar(false);
      }();
      return null;
    }, const []);

    final slides = Slide.values;
    void toggleFullscreen() async {
      final isNowFullscreen = await windowManager.isFullScreen();
      dev.log(
        'toggleFullscreen called -> currentFullscreen=$isNowFullscreen',
        name: 'Display',
      );
      if (isNowFullscreen) {
        dev.log('Exiting fullscreen (window_manager)', name: 'Display');
        await windowManager.setFullScreen(false);
      } else {
        dev.log('Entering fullscreen (window_manager)', name: 'Display');
        await windowManager.setFullScreen(true);
      }
    }
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      // : (hasFocus) {
      //   dev.log('RawKeyboardListener focus changed: $hasFocus', name: 'Display');
      // },
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          dev.log(
            'KeyDown detected: ${event.logicalKey.keyLabel}',
            name: 'Display',
          );
          if (event.logicalKey == LogicalKeyboardKey.keyF ||
              event.logicalKey == LogicalKeyboardKey.f11) {
            dev.log('Fullscreen key detected -> toggling', name: 'Display');
            toggleFullscreen();
          }
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