import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class AssetAudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    try {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate();
      }
      await _player.setAsset(assetPath);
      await _player.play();
      _player.dispose();
    } catch (e) {
      if (kDebugMode) {
        print("Audio error: $e");
      }
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
