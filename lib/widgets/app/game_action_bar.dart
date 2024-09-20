import 'package:flutter/material.dart';

class ActionItem {
  final IconData icon; // The type for icon is strictly IconData
  final VoidCallback
      action; // The type for action is a function that returns void

  ActionItem({
    required this.icon,
    required this.action,
  });
}

class GameActionBar extends StatelessWidget {
  final List<ActionItem> actions;

  const GameActionBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/app/balance_bg.png"),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Image.asset("assets/images/app/pcoin.png"),
                onPressed: () {},
              ),
              const SizedBox(width: 6),
              const Text(
                '120',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(width: 6),
              IconButton(
                icon: Image.asset("assets/images/app/add_green.png"),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Row(
          children: actions.map((actionItem) {
            return GestureDetector(
              onTap: actionItem.action, // Trigger the action
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/images/app/blue_block.png"),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(
                      actionItem.icon, // Display the icon
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
