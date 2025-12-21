import 'package:church_school_saints_day/models/music.dart';

abstract final class EffectMusics {
  static const Music boat = EffectMusic(
    path: 'assets/musics/effects/boat.mp3',
    name: '뱃고동',
  );
  static const Music closing = EffectMusic(
    path: 'assets/musics/effects/closing.m4a',
    name: '문 닫기',
  );
  static const Music fighting = EffectMusic(
    path: 'assets/musics/effects/fighting.mp3',
    name: '싸움',
  );
  static const Music knock = EffectMusic(
    path: 'assets/musics/effects/knock.m4a',
    name: '노크',
  );
  static const Music opening = EffectMusic(
    path: 'assets/musics/effects/opening.m4a',
    name: '문 열기',
  );
  static const Music pigs = EffectMusic(
    path: 'assets/musics/effects/pigs.mp3',
    name: '돼지',
  );
  static const Music twinkle = EffectMusic(
    path: 'assets/musics/effects/twinkle.mp3',
    name: '샤랄랑',
  );

  static const List<Music> values = [
    boat,
    closing,
    fighting,
    opening,
    pigs,
    twinkle,
  ];
}
