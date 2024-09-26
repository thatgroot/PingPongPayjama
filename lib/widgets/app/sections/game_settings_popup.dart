import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyjama_pingpong/game/audio_manager.dart';
import 'package:pyjama_pingpong/providers/providers.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';
import 'package:pyjama_pingpong/utils/hive.dart';
import 'package:pyjama_pingpong/widgets/app/sections/popover_container.dart';
import 'package:pyjama_pingpong/widgets/app/toggle.dart';

class SettingActionItem {
  final Image buttonImage; // The type for icon is strictly IconData
  final VoidCallback
      action; // The type for action is a function that returns void

  SettingActionItem({
    required this.buttonImage,
    required this.action,
  });
}

class GameSettingsPopup extends StatefulWidget {
  final List<SettingActionItem> actions;
  final void Function()? onExit;
  final String label;
  final bool gameInfo;
  final bool gameCompleted;

  const GameSettingsPopup({
    super.key,
    this.gameInfo = false,
    this.gameCompleted = false,
    required this.label,
    required this.onExit,
    required this.actions,
  });

  @override
  State<GameSettingsPopup> createState() => GameSettingsPopupState();
}

class GameSettingsPopupState extends State<GameSettingsPopup> {
  bool bgmEnabled = true;
  bool soundEnabled = true;

  @override
  void initState() {
    super.initState();
    getData("sound").then((s) {
      setState(() {
        soundEnabled = s ?? true;
      });
    });
    getData("bgm").then((s) {
      if (s == null) {
        AudioManager.playBackgroundMusic();
        saveData("bgm", true);
      } else {}
      setState(() {
        bgmEnabled = s ?? true;
      });
    });
    // Provider.of<GameProvider>(ContextUtility.context!, listen: false).sound;
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider =
        Provider.of<GameProvider>(ContextUtility.context!, listen: false);
    return PopoverContainer(
      children: [
        Stack(
          clipBehavior: Clip.none, // Disable clipping
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: widget.gameCompleted ? 32 : 0),
              decoration: BoxDecoration(
                color: const Color(0xFF340189),
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
                border: Border.all(
                  width: 3,
                  color: const Color(0xFFD39CFF),
                ),
              ),
              child: Column(
                children: [
                  widget.gameCompleted
                      ? const SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          height: 100,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1.00, 0.00),
                              end: Alignment(-1, 0),
                              colors: [
                                Color(0x0046229D),
                                Color(0xFFAC48FB),
                                Color(0x0046229D),
                              ],
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                right: 24.0,
                                child: GestureDetector(
                                  onTap: widget.onExit,
                                  child: Image.asset(
                                      "assets/images/app/close.png"),
                                ),
                              ),
                              Text(
                                widget.label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 36.0),
                  widget.gameCompleted
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GameInfo(
                              label: "Level",
                              count: "01",
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            GameInfo(
                              label: "Coins :",
                              count: "30",
                              postImage: Image(
                                image: AssetImage("assets/images/app/coin.png"),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ToggleSwitch(
                                image: Image.asset(
                                    "assets/images/app/speaker.png"),
                                label: "Sound",
                                active: soundEnabled,
                                onChanged: (_value) {
                                  bool value = gameProvider.sound;
                                  saveData("sound", !value);
                                  AudioManager.sound = !value;
                                  gameProvider.toggleSound();
                                  setState(() {
                                    soundEnabled = gameProvider.sound;
                                  });
                                },
                              ),
                              const SizedBox(height: 20.0),
                              ToggleSwitch(
                                image:
                                    Image.asset("assets/images/app/music.png"),
                                label: "Music",
                                active: bgmEnabled,
                                onChanged: (_value) {
                                  bool value = gameProvider.bgm;
                                  saveData("bgm", !value);
                                  if (value) {
                                    AudioManager.stopBackgroundMusic();
                                  } else {
                                    AudioManager.playBackgroundMusic();
                                  }
                                  gameProvider.toggleBgm();

                                  print("sound provider ${gameProvider.sound}");
                                  setState(() {
                                    bgmEnabled = gameProvider.bgm;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 36.0),
                  ...widget.actions.map(
                    (item) => Column(
                      children: [
                        GestureDetector(
                          onTap: item.action,
                          child: item.buttonImage,
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.gameCompleted) // Positioned image for gameInfo
              Positioned(
                top: -54,
                left: 0,
                right: 0,
                child: Image.asset("assets/images/app/completed.png"),
              ),
          ],
        ),
      ],
    );
  }
}

class GameInfo extends StatelessWidget {
  final String label;
  final String count;
  final Widget postImage;
  const GameInfo({
    super.key,
    required this.label,
    required this.count,
    this.postImage =
        const SizedBox(), // Default value is an empty SizedBox if no image is provided
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 60,
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 18,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF7327EE).withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Row(
            children: [
              Text(
                count,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(width: 12),
              postImage,
            ],
          )
        ],
      ),
    );
  }
}
