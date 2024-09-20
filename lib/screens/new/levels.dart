import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/screens/new/home.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';
import 'package:pyjama_pingpong/utils/navigation.dart';
import 'package:pyjama_pingpong/widgets/app/level_block.dart';
import 'package:pyjama_pingpong/widgets/app/wrapper.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, 0.00),
                end: Alignment(-1, 0),
                colors: [
                  Color(0x0046229D),
                  Color(0xFFAC48FB),
                  Color(0x0046229D)
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      to(ContextUtility.context!, HomeScreen());
                    },
                    child: Image.asset("assets/images/app/back_button.png"),
                  ),
                ),
                const Text(
                  'Levels',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 128.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: GridView.count(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          shrinkWrap: true, // Prevent infinite expansion
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling, let parent handle it
                          children: [
                            const LevelBlock(
                              gradient: [Color(0xFF2CF706), Color(0xFF05716B)],
                              shadow: Color(0xFF2CF706),
                              border: Colors.white,
                              label: "1",
                            ),
                            const LevelBlock(
                              gradient: [Color(0xFFF3D920), Color(0xFFFF751C)],
                              shadow: Color(0xFF873700),
                              border: Colors.white,
                              label: "2",
                            ),
                            ...List.generate(6, (index) {
                              return LevelBlock(
                                label: "${index + 3}",
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Indicator(
                        active: true,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Indicator(),
                      SizedBox(
                        width: 16,
                      ),
                      Indicator(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool active;
  const Indicator({
    super.key,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.transparent, // Outer container is transparent
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: Colors.white, // White border for outer container
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          4.0,
        ), // Creates a gap between outer and inner container
        child: !active
            ? Container()
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white, // Inner container with white color
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Optional: Rounded corners for inner container
                ),
              ),
      ),
    );
  }
}
