import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountDown extends StatelessWidget {
  const CountDown({
    super.key,
    required this.startGame,
  });

  final VoidCallback startGame;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Countdown(
          seconds: 3,
          interval: const Duration(seconds: 1),
          onFinished: startGame,
          build: (BuildContext context, double time) {
            if (time == 0) {
              return const CountDownText(text: 'GO !');
            } else {
              return CountDownText(text: time.toInt().toString());
            }
          }),
    );
  }
}

class CountDownText extends StatelessWidget {
  const CountDownText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 70, color: Colors.white),
    );
  }
}
