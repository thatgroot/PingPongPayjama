import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/screens/home.dart';
import 'package:pyjama_pingpong/utils/navigation.dart';
import 'package:pyjama_pingpong/widgets/app/animated_image.dart';
import 'package:pyjama_pingpong/widgets/app/animated_progress_bar.dart';
import 'package:pyjama_pingpong/widgets/app/wrapper.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImage(
              image: Image.asset(
                'assets/images/pyjama/pyjama.png',
                width: 241,
                height: 241,
              ),
            ),
            const Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            AnimatedProgressBar(
              onProgressChanged: (progress) {
                if (progress == 1.0) {
                  to(
                    context,
                    // const CharacterSelectionScreen(),
                    // LevelsScreen(),
                    HomeScreen(),
                  );
                }
                // Handle progress change
                log('Loading Screen -> Progress: $progress');
              },
            ),
          ],
        ),
      ),
    );
  }
}
