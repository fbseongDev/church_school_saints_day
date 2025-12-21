import 'package:church_school_saints_day/models/music.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final Map<Music, AudioPlayer> _players = {};
  double _backgroundVolume = 1.0;

  Future<void> playAsset(
      Music asset, {
        bool loop = false,
        double volume = 1.0,
      }) async {

    // 기존 플레이어 완전히 제거
    final oldPlayer = _players.remove(asset);
    if (oldPlayer != null) {
      try {
        await oldPlayer.dispose();
      } catch (_) {}
    }

    // ⭐ 항상 새 플레이어로 시작
    final player = AudioPlayer();
    _players[asset] = player;

    try {
      await player.setAsset(asset.path);
      await player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
      final effectiveVolume =
          asset is BackgroundMusic ? _backgroundVolume : volume;
      await player.setVolume(effectiveVolume);
      await player.play();

      // 재생 완료 시 정리
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed &&
            !loop) {
          player.pause();
          player.seek(Duration.zero);
        }
      });
    } catch (e) {
      _players.remove(asset);
      await player.dispose();
      print('Error playing $asset: $e');
    }
  }

  Future<void> stop(Music asset) async {
    final player = _players.remove(asset);
    if (player != null) {
      await player.dispose();
    }
  }

  Future<void> setVolume(Music asset, double volume) async {
    final player = _players[asset];
    if (player != null) {
      await player.setVolume(volume);
    }
  }

  Future<void> setAllVolume(double volume) async {
    for (final player in _players.values) {
      await player.setVolume(volume);
    }
  }

  Future<void> setBackgroundVolume(double volume) async {
    _backgroundVolume = volume;
    for (final entry in _players.entries) {
      if (entry.key is BackgroundMusic) {
        await entry.value.setVolume(volume);
      }
    }
  }

  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
  }
}