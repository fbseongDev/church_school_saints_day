import 'package:church_school_saints_day/models/music.dart';

abstract final class EffectMusics {
  static const Music closing = Music(
    path: 'assets/musics/effects/closing.mp3',
    name: '문 닫기',
  );
  static const Music fighting = Music(
    path: 'assets/musics/effects/fighting.mp3',
    name: '싸움',
  );
  static const Music knock = Music(
    path: 'assets/musics/effects/knock.mp3',
    name: '노크',
  );
  static const Music opening = Music(
    path: 'assets/musics/effects/opening.mp3',
    name: '문 열기',
  );
  static const Music pigs = Music(
    path: 'assets/musics/effects/pigs.mp3',
    name: '돼지',
  );
  static const Music twinkle = Music(
    path: 'assets/musics/effects/twinkle.mp3',
    name: '샤랄랑',
  );

  static const List<Music> values = [closing, fighting, opening, pigs, twinkle];
}
