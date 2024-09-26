import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/game/game.dart';

import '/game/audio_manager.dart';

// This represents the head up display in game.
// It consists of, current score, high score,
// a pause button and number of remaining lives.
class Hud extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'Hud';

  // Reference to parent game.
  final PingPongGame game;

  const Hud(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'Score: ${game.score}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                'High: ${game.score}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              game.overlays.remove(Hud.id);
              // game.overlays.add(PauseMenu.id);
              game.pauseEngine();
              AudioManager.pauseBackgroundMusic();
            },
            child: const Icon(Icons.pause, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
