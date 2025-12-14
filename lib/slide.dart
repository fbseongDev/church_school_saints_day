import 'package:church_school_saints_day/models/music.dart';
import 'package:flutter/cupertino.dart';

import 'assets/images.dart';
import 'assets/musics/background_musics.dart';

enum Slide {
  scene1(
    name: '탕자의 집',
    screen: Images.home,
    musics: [BackgroundMusics.narration],
  ),
  scene2(
    name: '탕자 집마당',
    screen: Images.yard,
    musics: [BackgroundMusics.mainCharacter],
  ),
  scene3(name: '안방', screen: Images.room, musics: []),
  scene4(
    name: '이방나라',
    screen: Images.nation,
    musics: [BackgroundMusics.narration],
  ),
  scene5(
    name: '노래방',
    screen: Images.karaoke,
    musics: [BackgroundMusics.karaoke, BackgroundMusics.karaoke],
  ),
  scene6(name: '뒷골목', screen: Images.alley, musics: [BackgroundMusics.illzyn]),
  scene7(name: '탕자 집마당', screen: Images.yard, musics: []),
  scene8(
    name: '길거리',
    screen: Images.street,
    musics: [BackgroundMusics.sadness, BackgroundMusics.master],
  ),
  scene9(
    name: '돼지 우리',
    screen: Images.pigpen,
    musics: [BackgroundMusics.master, BackgroundMusics.sadness],
  ),
  scene10(
    name: '탕자의 집',
    screen: Images.home,
    musics: [BackgroundMusics.end, BackgroundMusics.running],
  );

  final String name;
  final AssetImage screen;
  final List<Music> musics;

  const Slide({required this.name, required this.screen, required this.musics});
}
