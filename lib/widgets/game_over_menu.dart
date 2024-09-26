import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyjama_pingpong/game/game.dart';

import '/widgets/hud.dart';
import '/game/audio_manager.dart';

// This represents the game over overlay,
// displayed with dino runs out of lives.
class GameOverMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'GameOverMenu';

  // Reference to parent game.
  final PingPongGame game;

  const GameOverMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Selector<int, int>(
                    selector: (_, score) => score,
                    builder: (_, score, __) {
                      return Text(
                        'You Score: $score',
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      game.overlays.remove(GameOverMenu.id);
                      game.overlays.add(Hud.id);
                      game.resumeEngine();
                      game.resetGame();
                      // game.startGamePlay();
                      AudioManager.playBackgroundMusic();
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      // to(context, const CharacterDisplayScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
