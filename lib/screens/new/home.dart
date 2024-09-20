import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/screens/new/levels.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';
import 'package:pyjama_pingpong/utils/navigation.dart';
import 'package:pyjama_pingpong/widgets/app/game_action_bar.dart';
import 'package:pyjama_pingpong/widgets/app/sections/game_settings_popup.dart';
import 'package:pyjama_pingpong/widgets/app/sections/popover_manager.dart';
import 'package:pyjama_pingpong/widgets/app/wrapper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PopoverManager _popoverManager = PopoverManager();
  // Create an instance of PopoverManager

  @override
  Widget build(BuildContext context) {
    void showSettingsOverlay() {
      _popoverManager.showOverlay(
        context,
        GameSettingsPopup(
          label: "Settings",
          onExit: _popoverManager.removeOverlay,
          actions: [
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/exit.png"),
              action: _popoverManager.removeOverlay,
            )
          ],
        ),
      );
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
              action: _popoverManager.removeOverlay,
            ),
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/exit.png"),
              action: _popoverManager.removeOverlay,
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
          label: "Pause",
          onExit: _popoverManager.removeOverlay,
          actions: [
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/next.png"),
              action: _popoverManager.removeOverlay,
            ),
            SettingActionItem(
              buttonImage: Image.asset("assets/images/app/exit.png"),
              action: _popoverManager.removeOverlay,
            ),
          ],
        ),
      );
    }

    return Wrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 24.0,
        ),
        child: Column(
          children: [
            GameActionBar(actions: [
              ActionItem(
                icon: Icons.replay,
                action: showGameCompletedOverlay,
              ),
              ActionItem(
                icon: Icons.pause,
                action: showGamePauseOverlay,
              ),
              ActionItem(
                icon: Icons.settings,
                action: showSettingsOverlay,
              ),
            ]),
            const SizedBox(height: 50),
            Image.asset("assets/images/app/pingpon-pyjama.png"),
            const SizedBox(height: 10),
            Image.asset("assets/images/app/earn-coin.png"),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                to(ContextUtility.context!, const LevelsScreen());
              },
              child: Image.asset("assets/images/app/play_button.png"),
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Image.asset("assets/images/app/about_button.png"),
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            TextButton(
              child: Image.asset("assets/images/app/exit_button.png"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
