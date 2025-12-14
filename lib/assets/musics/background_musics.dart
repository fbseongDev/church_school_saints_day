import 'package:church_school_saints_day/models/music.dart';

abstract final class BackgroundMusics {
  static const Music narration = Music(
    path: 'assets/musics/background/narration.mp3',
    name: '나레이션',
  );
  static const Music karaoke = Music(
    path: 'assets/musics/background/karaoke.mp3',
    name: '노래방',
  );
  static const Music running = Music(
    path: 'assets/musics/background/running.mp3',
    name: '달리기',
  );
  static const Music end = Music(
    path: 'assets/musics/background/end.mp3',
    name: '막',
  );
  static const Music sadness = Music(
    path: 'assets/musics/background/sadness.mp3',
    name: '아련',
  );
  static const Music illzyn = Music(
    path: 'assets/musics/background/illzyn.mp3',
    name: '일쯴',
  );
  static const Music master = Music(
    path: 'assets/musics/background/master.mp3',
    name: '주인',
  );
  static const Music mainCharacter = Music(
    path: 'assets/musics/background/mainCharacter.mp3',
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
