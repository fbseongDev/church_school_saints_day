import 'package:church_school_saints_day/models/music.dart';
import 'package:flutter/cupertino.dart';

import 'assets/images.dart';
import 'assets/musics/background_musics.dart';
import 'assets/musics/effect_musics.dart';

enum Slide {
  scene1(
    name: '탕자의 집',
    screen: Images.home,
    backgrounds: [BackgroundMusics.narration],
    effects: [],
  ),
  scene2(
    name: '탕자 집마당',
    screen: Images.yard,
    backgrounds: [BackgroundMusics.mainCharacter],
    effects: [],
  ),
  scene3(
    name: '안방',
    screen: Images.room,
    backgrounds: [],
    effects: [EffectMusics.twinkle],
  ),
  scene4(
    name: '이방나라',
    screen: Images.nation,
    backgrounds: [BackgroundMusics.narration],
    effects: [],
  ),
  scene5(
    name: '노래방',
    screen: Images.karaoke,
    backgrounds: [BackgroundMusics.karaoke, BackgroundMusics.karaoke],
    effects: [EffectMusics.twinkle],
  ),
  scene6(
    name: '뒷골목',
    screen: Images.alley,
    backgrounds: [BackgroundMusics.illzyn],
    effects: [],
  ),
  scene7(name: '탕자 집마당', screen: Images.yard, backgrounds: [], effects: []),
  scene8(
    name: '길거리',
    screen: Images.street,
    backgrounds: [BackgroundMusics.sadness, BackgroundMusics.master],
    effects: [EffectMusics.knock, EffectMusics.opening],
  ),
  scene9(
    name: '돼지 우리',
    screen: Images.pigpen,
    backgrounds: [BackgroundMusics.master, BackgroundMusics.sadness],
    effects: [EffectMusics.closing, EffectMusics.pigs, EffectMusics.fighting],
  ),
  scene10(
    name: '탕자의 집',
    screen: Images.home,
    backgrounds: [BackgroundMusics.end, BackgroundMusics.running],
    effects: [],
  );

  final String name;
  final AssetImage screen;
  final List<Music> backgrounds;
  final List<Music> effects;

  const Slide({
    required this.name,
    required this.screen,
    required this.backgrounds,
    required this.effects,
  });
}
