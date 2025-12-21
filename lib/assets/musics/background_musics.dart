import 'package:church_school_saints_day/models/music.dart';

abstract final class BackgroundMusics {
  static const Music narration = BackgroundMusic(
    path: 'assets/musics/backgrounds/narration.mp3',
    name: '나레이션',
  );
  static const Music karaoke = BackgroundMusic(
    path: 'assets/musics/backgrounds/karaoke.m4a',
    name: '노래방',
  );
  static const Music running = BackgroundMusic(
    path: 'assets/musics/backgrounds/running.mp3',
    name: '달리기',
  );
  static const Music end = BackgroundMusic(
    path: 'assets/musics/backgrounds/end.mp3',
    name: '막',
  );
  static const Music sadness = BackgroundMusic(
    path: 'assets/musics/backgrounds/sadness.mp3',
    name: '아련',
  );
  static const Music illzyn = BackgroundMusic(
    path: 'assets/musics/backgrounds/illzyn.mp3',
    name: '일쯴',
  );
  static const Music master = BackgroundMusic(
    path: 'assets/musics/backgrounds/master.mp3',
    name: '주인',
  );
  static const Music mainCharacter = BackgroundMusic(
    path: 'assets/musics/backgrounds/mainCharacter.mp3',
    name: '탕자',
  );

  static const List<Music> values = [
    narration,
    karaoke,
    running,
    end,
    sadness,
    illzyn,
    master,
    mainCharacter,
  ];
}
