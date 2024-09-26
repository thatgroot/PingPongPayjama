import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/game/game.dart';

import '/widgets/main_menu.dart';

// This represents the settings menu overlay.
class SettingsMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'SettingsMenu';

  // Reference to parent game.
  final PingPongGame game;

  const SettingsMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchListTile(
                    title: const Text(
                      'Music',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    value: true,
                    onChanged: (bool value) {},
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Effects',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    value: false,
                    onChanged: (bool value) {},
                  ),
                  TextButton(
                    onPressed: () {
                      game.overlays.remove(SettingsMenu.id);
                      game.overlays.add(MainMenu.id);
                    },
                    child: const Icon(Icons.arrow_back_ios_rounded),
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
