import 'package:flutter/material.dart';
import 'package:scoreboard/model/domain/Countdown.dart';

class PauseResumeButton extends StatefulWidget {
  const PauseResumeButton({super.key, required this.countdown});

  final Countdown countdown;

  @override
  State<PauseResumeButton> createState() => _PauseResumeButtonState();
}

class _PauseResumeButtonState extends State<PauseResumeButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 100,
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
              if (widget.countdown.isPaused) {
                widget.countdown.controllerCountdown.resume();
              } else {
                widget.countdown.controllerCountdown.pause();
              }
              widget.countdown.isPaused = !widget.countdown.isPaused;
            });
          },
          child: Text(
            widget.countdown.isPaused ? "Resume" : "Pause",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
