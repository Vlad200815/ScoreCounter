import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class MyConfetti extends StatelessWidget {
  const MyConfetti({
    super.key,
    required this.confettiController,
  });

  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive, // Explosion style
      emissionFrequency: 0.05, // Frequency of confetti particles
      numberOfParticles: 90, // Number of confetti particles
      gravity: 0.5, // Gravity to control how fast confetti falls
      shouldLoop: false, // Looping effect for continuous confetti
    );
  }
}
