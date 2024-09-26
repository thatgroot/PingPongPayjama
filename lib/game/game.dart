import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:provider/provider.dart';
import 'package:pyjama_pingpong/providers/providers.dart';
import 'package:pyjama_pingpong/screens/home.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';
import 'package:pyjama_pingpong/utils/navigation.dart';
import 'package:pyjama_pingpong/widgets/app/sections/game_settings_popup.dart';
import 'paddle.dart';
import 'ball.dart';
import 'brick.dart';
import 'audio_manager.dart';
import 'package:flutter/material.dart';

class PingPongGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  late Paddle paddle;
  late Ball ball;
  final List<Brick> bricks = [];
  final BuildContext context;
  int score = 0;
  int level = 1;
  // late TextComponent levelText;
  bool isPaused = false;

  PingPongGame(this.context);

  @override
  Future<void> onLoad() async {
    await AudioManager.load();

    final bgImage = await Flame.images.load('splashbg.png');
    add(SpriteComponent(sprite: Sprite(bgImage), size: size));

    ball = Ball(onBrickDestroyed: onBrickDestroyed)..anchor = Anchor.center;
    add(ball);

    paddle = Paddle(ball: ball)
      ..position = Vector2(size.x / 2, size.y - 50)
      ..anchor = Anchor.center;
    add(paddle);

    ball.position =
        Vector2(paddle.x, paddle.y - paddle.size.y / 2 - ball.size.y / 2 - 2);

    addBricks();
    // addScoreText();
    // addLevelText();
  }

  void addBricks() {
    const int brickColumns = 6;
    const int brickRows = 6;
    const double brickWidth = 58;
    const double brickHeight = 28;
    const double topPadding = 100;
    const double leftPadding = 10;

    for (int i = 0; i < brickColumns; i++) {
      for (int j = 0; j < brickRows; j++) {
        final brick = Brick()
          ..position = Vector2(
              leftPadding + i * brickWidth, topPadding + j * brickHeight)
          ..anchor = Anchor.topLeft;
        bricks.add(brick);
        add(brick);
      }
    }
  }

  // void addScoreText() {
  //   scoreText = TextComponent(
  //     text: 'Score: $score',
  //     textRenderer: TextPaint(
  //       style: const TextStyle(fontSize: 20, color: Colors.white),
  //     ),
  //     anchor: Anchor.topLeft,
  //     position: Vector2(10, 10),
  //   );
  //   add(scoreText);
  // }

  // void addLevelText() {
  //   levelText = TextComponent(
  //     text: 'Level $level',
  //     textRenderer: TextPaint(
  //       style: const TextStyle(fontSize: 20, color: Colors.white),
  //     ),
  //     anchor: Anchor.topCenter,
  //     position: Vector2(size.x / 2, 40),
  //   );
  //   add(levelText);
  // }

  void togglePause() {
    isPaused = !isPaused;
    if (isPaused) {
      pauseEngine();
    } else {
      resumeEngine();
    }
  }

  // void updateScoreText() {
  //   scoreText.text = 'Score: $score';
  // }

  // void updateLevelText() {
  //   levelText.text = 'Level $level';
  // }

  void onBrickDestroyed() {
    score += 10;
    // updateScoreText();
    final gameProvider =
        Provider.of<GameProvider>(ContextUtility.context!, listen: false);
    gameProvider.update(score);

    if (bricks.isEmpty) {
      pauseEngine();
      showLevelCompletePopup();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (ball.isOffScreen(size)) {
      pauseEngine();
      showGameOverPopup();
    }
  }

  void showLevelCompletePopup() {
    AudioManager.pauseBackgroundMusic();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return GameSettingsPopup(
          gameCompleted: true,
          gameInfo: true,
          label: "Level Complete",
          onExit: () {
            Navigator.of(dialogContext).pop();
            resetGame();
          },
          actions: [
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/next.png"),
              action: () {
                Navigator.of(dialogContext).pop();
                resetGameForNextLevel();
                AudioManager.resumeBackgroundMusic();
              },
            ),
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/exit.png"),
              action: () {
                to(ContextUtility.context!, HomeScreen());
              },
            ),
          ],
        );
      },
    );
  }

  void showGameOverPopup() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return GameSettingsPopup(
          gameInfo: true,
          label: "Game Over",
          onExit: () {
            Navigator.of(dialogContext).pop();
            resetGame();
          },
          actions: [
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/continue.png"),
              action: () {
                resetGame();
                AudioManager.resumeBackgroundMusic();
                Navigator.of(dialogContext).pop();
              },
            ),
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/exit.png"),
              action: () {
                to(ContextUtility.context!, HomeScreen());
              },
            ),
          ],
        );
      },
    );

    // showDialog(
    //   context: context,
    //   builder: (BuildContext dialogContext) {
    //     return AlertDialog(
    //       title: const Text('Game Over!'),
    //       content: const Text('You missed the ball. Try again?'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('Retry'),
    //           onPressed: () {
    // Navigator.of(dialogContext).pop();
    // resetGame();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void resetGameForNextLevel() {
    level++;
    // updateScoreText();
    final gameProvider =
        Provider.of<GameProvider>(ContextUtility.context!, listen: false);
    gameProvider.updateLevel(level);
    bricks.clear();
    removeAll(children);
    onLoad();
    // updateLevelText();
    resumeEngine();
    isPaused = false;
  }

  void resetGame() {
    final gameProvider =
        Provider.of<GameProvider>(ContextUtility.context!, listen: false);
    gameProvider.reset();

    score = 0;
    level = 1;
    bricks.clear();
    removeAll(children);
    onLoad();
    // updateScoreText();
    // updateLevelText();
    resumeEngine();
    isPaused = false;
  }
}
