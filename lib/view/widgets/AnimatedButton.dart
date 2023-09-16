import 'package:flutter/material.dart';

import '../../model/domain/Countdown.dart';
import '../../model/domain/Team.dart';
import 'PauseResumeButton.dart';
import 'StartRestartButton.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton(
      {super.key,
      required this.countdown,
      required this.teamOne,
      required this.teamTwo});

  final Countdown countdown;
  final Team teamOne, teamTwo;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool isMenuOpen = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      curve: Curves.easeInOut,
      height: 50,
      width: isMenuOpen ? 300.0 : 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isMenuOpen) ...[
            const SizedBox(width: 5),
            StartRestartButton(
                countdown: widget.countdown,
                teamOne: widget.teamOne,
                teamTwo: widget.teamTwo),
            const SizedBox(width: 5),
            PauseResumeButton(countdown: widget.countdown),
            const SizedBox(width: 5),
          ],
          SizedBox(
            width: 95,
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              },
              child: Icon(isMenuOpen ? Icons.close : Icons.menu),
            ),
          ),
        ],
      ),
    );
  }
}
