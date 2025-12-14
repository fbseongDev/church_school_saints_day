import 'package:just_audio/just_audio.dart';

class AudioManager {
  final Map<String, AudioPlayer> _players = {};

  Future<void> playAsset(
      String asset, {
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
      await player.setAsset(asset);
      await player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
      await player.setVolume(volume);
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

  Future<void> stop(String asset) async {
    final player = _players.remove(asset);
    if (player != null) {
      await player.dispose();
    }
  }

  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
  }
}