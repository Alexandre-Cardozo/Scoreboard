import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:scoreboard/minutes.dart';
import 'package:scoreboard/seconds.dart';

void main() {
  runApp(const MyApp());
}

class Team {
  int count = 0;
  final TextEditingController controller = TextEditingController(text: "0");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Scoreboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minutes = 0, _seconds = 0;
  final CountDownController _controllerCountdown = CountDownController();

  Team teamOne = Team();
  Team teamTwo = Team();

  bool isMenuOpen = false;
  bool _isCountdownRunning = false;
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.title!,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _countDown(),
              _circularTimer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _counterTeam(team: teamOne, number: 1),
                  const SizedBox(
                    width: 10,
                  ),
                  _counterTeam(team: teamTwo, number: 2),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _circularTimer() {
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
            duration: (_minutes * 60) + _seconds,
            // Countdown initial elapsed Duration in Seconds.
            initialDuration: 0,
            // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
            controller: _controllerCountdown,
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
              // Here, do whatever you want
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

  Widget _floatingButton() {
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
            _startButton(),
            const SizedBox(width: 5),
            _pauseButton(),
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

  Widget _pauseButton() {
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
              if (_isPaused) {
                _controllerCountdown.resume();
              } else {
                _controllerCountdown.pause();
              }
              _isPaused = !_isPaused;
            });
          },
          child: Text(
            _isPaused ? "Resume" : "Pause",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _startButton() {
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
              _controllerCountdown.restart(
                  duration: (_minutes * 60) + _seconds);
              _isCountdownRunning = true;

              //reseta os valores do placar
              teamOne.controller.text = "0";
              teamOne.count = 0;
              teamTwo.controller.text = "0";
              teamTwo.count = 0;

              //mudar o estado do botão pause
              _isPaused = false;
            });
          },
          child: Text(
            _isCountdownRunning ? "Restart" : "Start",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _counterTeam({required Team team, required int number}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Text("Team $number",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreen,
              ),
              child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (team.count > 0) {
                            team.count--;
                            team.controller.text = team.count.toString();
                          }
                        });
                      },
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 150,
                      width: 60,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 70.0,
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 33.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: team.controller,
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          team.count++;
                          team.controller.text = team.count.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countDown() {
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
                                _minutes = value;
                              });
                            },
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 60,
                                builder: (context, index) {
                                  return MyMinutes(
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
                                _seconds = value;
                              });
                            },
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 60,
                                builder: (context, index) {
                                  return MySeconds(
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
