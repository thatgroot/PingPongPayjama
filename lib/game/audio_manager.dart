import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static bool sound = true;
  static bool bgm = true;
  static Future<void> load() async {
    // Load sound effects and background music
    await FlameAudio.audioCache.loadAll([
      'hit_paddle.wav',
      'hit_bricks.wav',
      'bgm.mp3' // Make sure this file is in your assets
    ]);
  }

  // Play paddle hit sound
  static void playHitPaddle() {
    if (sound) {
      FlameAudio.play('hit_paddle.wav');
    }
  }

  // Play brick hit sound
  static void playHitBrick() {
    if (sound) {
      FlameAudio.play('hit_bricks.wav');
    }
  }

  static void playAll() {
    FlameAudio.play('hit_paddle.wav');
    FlameAudio.play('hit_bricks.wav');
  }

  // Play paddle hit sound
  static void clearAll() {
    FlameAudio.audioCache.clearAll();
  }

  // Play background music with looping
  static void playBackgroundMusic() {
    if (AudioManager.bgm) {
      FlameAudio.bgm.play('bgm.mp3', volume: 0.5); // Volume can be adjusted
    }
  }

  // Stop background music
  static void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  // Pause background music
  static void pauseBackgroundMusic() {
    FlameAudio.bgm.pause();
  }

  // Resume background music
  static void resumeBackgroundMusic() {
    FlameAudio.bgm.resume();
  }
}
