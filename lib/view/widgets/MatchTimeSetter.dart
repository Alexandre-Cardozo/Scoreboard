import 'package:flutter/material.dart';

import '../../model/domain/Countdown.dart';
import 'MinutesScroll.dart';
import 'SecondsScroll.dart';

class MatchTimeSetter extends StatefulWidget {
  const MatchTimeSetter({super.key, required this.countdown});

  final Countdown countdown;

  @override
  State<MatchTimeSetter> createState() => _MatchTimeSetterState();
}

class _MatchTimeSetterState extends State<MatchTimeSetter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 170,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 50,
              child: Text("Timer",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Minutes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                widget.countdown.minutes = value;
                              });
                            },
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 60,
                                builder: (context, index) {
                                  return MinutesScroll(
                                    mins: index,
                                  );
                                })),
                      ),
                      const SizedBox(
                        width: 10,
                        child: Text(
                          ":",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                widget.countdown.seconds = value;
                              });
                            },
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 60,
                                builder: (context, index) {
                                  return SecondsScroll(
                                    secs: index,
                                  );
                                })),
                      ),
                    ],
                  ),
                  const Text("Seconds",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
