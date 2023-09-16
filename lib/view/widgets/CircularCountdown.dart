import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/model/domain/Countdown.dart';

class CircularCountdown extends StatefulWidget {
  const CircularCountdown({super.key, required this.countdown});

  final Countdown countdown;

  @override
  State<CircularCountdown> createState() => _CircularCountdownState();
}

class _CircularCountdownState extends State<CircularCountdown> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text("Countdown",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: CircularCountDownTimer(
            // Countdown duration in Seconds.
            duration:
                (widget.countdown.minutes * 60) + widget.countdown.seconds,
            // Countdown initial elapsed Duration in Seconds.
            initialDuration: 0,
            // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
            controller: widget.countdown.controllerCountdown,
            // Width of the Countdown Widget.
            width: MediaQuery.of(context).size.width / 2,
            // Height of the Countdown Widget.
            height: MediaQuery.of(context).size.height / 4,
            // Ring Color for Countdown Widget.
            ringColor: Colors.grey[300]!,
            // Ring Gradient for Countdown Widget.
            ringGradient: null,
            // Filling Color for Countdown Widget.
            fillColor: Colors.green[200]!,
            // Filling Gradient for Countdown Widget.
            fillGradient: null,
            // Background Color for Countdown Widget.
            backgroundColor: Colors.lightGreen[500],
            // Background Gradient for Countdown Widget.
            backgroundGradient: null,
            // Border Thickness of the Countdown Ring.
            strokeWidth: 20.0,
            // Begin and end contours with a flat edge and no extension.
            strokeCap: StrokeCap.round,
            // Text Style for Countdown Text.
            textStyle: const TextStyle(
              fontSize: 60.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            // Format for the Countdown Text.
            textFormat: CountdownTextFormat.S,
            // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
            isReverse: false,
            // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
            isReverseAnimation: false,
            // Handles visibility of the Countdown Text.
            isTimerTextShown: true,
            // Handles the timer start.
            autoStart: false,
            // This Callback will execute when the Countdown Starts.
            onStart: () {
              // Here, do whatever you want
              debugPrint('Countdown Started');
            },
            // This Callback will execute when the Countdown Ends.
            onComplete: () {
              debugPrint('Countdown Ended');
            },
            // This Callback will execute when the Countdown Changes.
            onChange: (String timeStamp) {
              // Here, do whatever you want
              debugPrint('Countdown Changed $timeStamp');
            },
            /*
                        * Function to format the text.
                        * Allows you to format the current duration to any String.
                        * It also provides the default function in case you want to format specific moments
                          as in reverse when reaching '0' show 'GO', and for the rest of the instances follow
                          the default behavior.
                      */
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              return Function.apply(defaultFormatterFunction, [duration]);
            },
          ),
        ),
      ],
    );
  }
}
