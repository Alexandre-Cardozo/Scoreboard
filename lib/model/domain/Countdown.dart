import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Countdown{
  int minutes = 0;
  int seconds = 0;

  bool isCountdownRunning = false;
  bool isPaused = false;

  final CountDownController controllerCountdown = CountDownController();
}