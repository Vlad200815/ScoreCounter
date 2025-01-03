import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/update_bool_cubit/update_bool_cubit.dart';
import 'package:score_counter/features/home/widgets/my_confetti.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter1 = 0;
  int counter2 = 0;

  int firstPlayerWonRounds = 0;
  int secondPlayerWonRounds = 0;

  String firstTeamName = "Basa";
  String secondTeamName = "Pety";

  Offset? _startVerticalDragDetails;

  late ConfettiController _confettiController1;
  late ConfettiController _confettiController2;

  bool isFirstPlayerVictory = false;
  bool isSecondPlayerVictory = false;

  @override
  void initState() {
    super.initState();
    _confettiController1 =
        ConfettiController(duration: Duration(microseconds: 40));
    _confettiController2 =
        ConfettiController(duration: Duration(microseconds: 40));
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController1.dispose();
    _confettiController2.dispose();
  }

  void increaceCounters(int counterIndex) {
    if (counterIndex == 1) {
      setState(() {
        counter1++;
      });
    } else {
      setState(() {
        counter2++;
      });
    }
  }

  void decreaceCounters(int counterIndex) {
    if (counterIndex == 1) {
      setState(() {
        counter1--;
      });
    } else {
      setState(() {
        counter2--;
      });
    }
  }

  void _startFirstConfetti() {
    _confettiController1.play();
  }

  void _startSecondConfetti() {
    _confettiController2.play();
  }

  Future<void> _triggerDelayActionOfFirstPlayer() async {
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      isFirstPlayerVictory = false;
    });
  }

  Future<void> _triggerDelayActionOfSecondPlayer() async {
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      isSecondPlayerVictory = false;
    });
  }

  Future<void> isVictoryOrNo() async {
    if (counter1 > counter2) {
      setState(() {
        isFirstPlayerVictory = true;
      });

      _startFirstConfetti();
      await _triggerDelayActionOfFirstPlayer();
      log("$isFirstPlayerVictory must be false");
    } else if (counter2 > counter1) {
      setState(() {
        isSecondPlayerVictory = true;
      });

      _startSecondConfetti();
      await _triggerDelayActionOfSecondPlayer();

      log("$isSecondPlayerVictory must be false");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UpdateBoolCubit, bool>(
        builder: (context, state) {
          log(context.read<UpdateBoolCubit>().state.toString());
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter1 = TextPainter(
                    text: TextSpan(
                      text: firstTeamName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  final firstTeamNameWidth = textPainter1.size.width;
                  final centerX1 =
                      (constraints.maxWidth - firstTeamNameWidth) / 2;

                  final textPainter2 = TextPainter(
                    text: TextSpan(
                      text: secondTeamName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  final secondTeamNameWidth = textPainter2.size.width;
                  final centerX2 =
                      (constraints.maxWidth - secondTeamNameWidth) / 2;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onVerticalDragStart: (details) {
                                _startVerticalDragDetails =
                                    details.globalPosition;
                              },
                              onVerticalDragEnd: (details) async {
                                if (_startVerticalDragDetails != null) {
                                  final double verticalDistance =
                                      details.velocity.pixelsPerSecond.dy;

                                  if (verticalDistance > 0) {
                                    decreaceCounters(1);
                                  } else {
                                    increaceCounters(1);
                                  }
                                }
                                //TODO: imporove victory logic here
                                await isVictoryOrNo();
                              },
                              child: Container(
                                color: Colors.lightBlue,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        firstTeamName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        counter1.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 150,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 5,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onVerticalDragStart: (details) {
                                _startVerticalDragDetails =
                                    details.globalPosition;
                              },
                              onVerticalDragEnd: (details) async {
                                if (_startVerticalDragDetails != null) {
                                  final double verticalDistance =
                                      details.velocity.pixelsPerSecond.dy;
                                  if (verticalDistance > 0) {
                                    decreaceCounters(2);
                                  } else {
                                    increaceCounters(2);
                                  }
                                }
                                //TODO: imporove victory logic here
                                await isVictoryOrNo();
                              },
                              child: Container(
                                color: Colors.redAccent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        secondTeamName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        counter2.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 150,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width - 70,
                        top: 45,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/settings");
                          },
                          child: Image.asset(
                            "assets/settings.webp",
                            color: Colors.white,
                            scale: 9,
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2 - 75,
                        left: MediaQuery.of(context).size.width - 65,
                        child: Container(
                          height: 150,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        firstPlayerWonRounds++;
                                      });
                                    },
                                    child: Text(
                                      firstPlayerWonRounds.toString(),
                                      style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[300],
                                height: 1,
                              ),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        secondPlayerWonRounds++;
                                      });
                                    },
                                    child: Text(
                                      secondPlayerWonRounds.toString(),
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2 - 30,
                        left: MediaQuery.of(context).size.width / 2 - 100,
                        child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    log(isFirstPlayerVictory.toString()),
                                icon: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "10:02",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 3),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    counter1 = 0;
                                    counter2 = 0;
                                    firstPlayerWonRounds = 0;
                                    secondPlayerWonRounds = 0;
                                  });
                                },
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isFirstPlayerVictory,
                        child: Positioned(
                          top: MediaQuery.of(context).size.width / 10,
                          left: centerX1 - 40,
                          // firstTeamNameTextWidth,
                          child: Transform.rotate(
                            angle: -45 * 3.14159265359 / 180,
                            child: Image.asset(
                              "assets/crown.png",
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isSecondPlayerVictory,
                        child: Positioned(
                          top: MediaQuery.of(context).size.height / 1.833,
                          left: centerX2 - 40,
                          child: Transform.rotate(
                            angle: -45 * 3.14159265359 / 180,
                            child: Image.asset(
                              "assets/crown.png",
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width / 2.2,
                        left: MediaQuery.of(context).size.width / 2,
                        child: MyConfetti(
                          confettiController: _confettiController1,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 1.4,
                        left: MediaQuery.of(context).size.width / 2,
                        child: MyConfetti(
                          confettiController: _confettiController2,
                        ),
                      ),
                    ],
                  );
                },
              ),
              state == true ? Instruction() : Container(),
            ],
          );
        },
      ),
    );
  }
}
