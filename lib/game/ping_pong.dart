import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:pyjama_pingpong/game/game.dart';
import 'package:pyjama_pingpong/screens/home.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';
import 'package:pyjama_pingpong/utils/navigation.dart';
import 'package:pyjama_pingpong/widgets/app/game_action_bar.dart';
import 'package:pyjama_pingpong/widgets/app/sections/game_settings_popup.dart';
import 'package:pyjama_pingpong/widgets/app/sections/popover_manager.dart';
import 'package:pyjama_pingpong/widgets/app/wrapper.dart';

class PinpPong extends StatefulWidget {
  const PinpPong({super.key});

  @override
  _PinpPongState createState() => _PinpPongState();
}

class _PinpPongState extends State<PinpPong> {
  final PopoverManager _popoverManager = PopoverManager();
  bool paused = false;
  late PingPongGame _game;

  @override
  void initState() {
    super.initState();
    _game = PingPongGame(context);
    setState(() {
      paused = _game.isPaused;
    });
  }

  void showGamePauseOverlay() {
    _popoverManager.showOverlay(
      context,
      GameSettingsPopup(
        gameInfo: true,
        label: "Pause",
        onExit: _popoverManager.removeOverlay,
        actions: [
          SettingActionItem(
            buttonImage: Image.asset("assets/images/app/continue.png"),
            action: () {
              _game.togglePause();
              _popoverManager.removeOverlay();
            },
          ),
          SettingActionItem(
            buttonImage: Image.asset("assets/images/app/exit.png"),
            action: () {
              // Implement exit logic, e.g., navigate to main menu
              _popoverManager.removeOverlay();
              to(ContextUtility.context!, HomeScreen());
            },
          ),
        ],
      ),
    );
  }

  void showGameCompletedOverlay() {
    _popoverManager.showOverlay(
      context,
      GameSettingsPopup(
        gameCompleted: true,
        gameInfo: true,
        label: "Level Complete",
        onExit: _popoverManager.removeOverlay,
        actions: [
          SettingActionItem(
            buttonImage: Image.asset("assets/images/app/next.png"),
            action: () {
              _game.resetGameForNextLevel();
              _popoverManager.removeOverlay();
            },
          ),
          SettingActionItem(
            buttonImage: Image.asset("assets/images/app/exit.png"),
            action: () {
              // Implement exit logic, e.g., navigate to main menu
              _popoverManager.removeOverlay();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      child: Stack(
        children: [
          // Game Widget
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GameWidget(
              game: _game,
            ),
          ),
          // Game Action Bar Overlay
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
            child: GameActionBar(
              actions: [
                // ActionItem(
                //   icon: Icons.replay,
                //   action: _game.resetGame,
                // ),
                ActionItem(
                  icon: paused ? Icons.play_circle : Icons.pause,
                  action: () {
                    _game.togglePause();
                    if (_game.isPaused) {
                      showGamePauseOverlay();
                    } else {
                      _popoverManager.removeOverlay();
                    }

                    setState(() {
                      paused = _game.isPaused;
                    });
                  },
                ),
                // ActionItem(
                //   icon: Icons.skip_next,
                //   action: _game.resetGameForNextLevel,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
