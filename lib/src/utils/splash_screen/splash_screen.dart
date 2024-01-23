import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: Colors.blue,
      splashScreenBody: const Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}
