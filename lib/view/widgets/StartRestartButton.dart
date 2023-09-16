import 'package:flutter/material.dart';

import '../../model/domain/Countdown.dart';
import '../../model/domain/Team.dart';

class StartRestartButton extends StatefulWidget {
  const StartRestartButton(
      {super.key,
      required this.countdown,
      required this.teamOne,
      required this.teamTwo});

  final Countdown countdown;
  final Team teamOne, teamTwo;

  @override
  State<StartRestartButton> createState() => _StartRestartButtonState();
}

class _StartRestartButtonState extends State<StartRestartButton> {
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
              //reinicia
              widget.countdown.controllerCountdown.restart(
                  duration: (widget.countdown.minutes * 60) +
                      widget.countdown.seconds);
              widget.countdown.isCountdownRunning = true;

              //reseta os valores do placar
              widget.teamOne.controller.text = "0";
              widget.teamOne.count = 0;
              widget.teamTwo.controller.text = "0";
              widget.teamTwo.count = 0;

              //mudar o estado do botão pause
              widget.countdown.isPaused = false;
            });
          },
          child: Text(
            widget.countdown.isCountdownRunning ? "Restart" : "Start",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
