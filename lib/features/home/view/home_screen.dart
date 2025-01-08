import 'dart:async';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/settings_cubit/settings_cubit.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset? _startVerticalDragDetails;

  late ConfettiController _confettiController1;
  late ConfettiController _confettiController2;

  bool isFirstPlayerVictory = false;
  bool isSecondPlayerVictory = false;

  bool isExpandedReset = false;

  //for timerCountDown
  Timer? timer;
  int mins = 0;
  int secs = 0;
  String secText = "";
  String minText = "";

  bool isStarted = false;
  bool isBeginning = false;
  bool isTimeUp = false;
  bool isResume = false;

  @override
  void initState() {
    super.initState();
    _confettiController1 =
        ConfettiController(duration: Duration(milliseconds: 40));
    _confettiController2 =
        ConfettiController(duration: Duration(milliseconds: 40));
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController1.dispose();
    _confettiController2.dispose();
  }

  //Functions for adding and subtracting the count
  void increaceCounters(int counterIndex, BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    if (counterIndex == 1) {
      cubit.incrementTeam1Points();
    } else {
      cubit.incrementTeam2Points();
    }
  }

  void decreaceCounters(int counterIndex, BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    if (counterIndex == 1) {
      cubit.decrementTeam1Points();
    } else {
      cubit.decrementTeam2Points();
    }
  }

  //Function for starting confetti
  void _startFirstConfetti() {
    _confettiController1.play();
  }

  void _startSecondConfetti() {
    _confettiController2.play();
  }

  void _startCountDown(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    if (!isResume) {
      String time = cubit.state.timer;

      List<String> myList = time.split('');

      if (myList[0] == "0") {
        mins = int.parse(myList[1]);
        minText = "0${myList[1]}";
      } else {
        String fullMin = "${myList[0]}${myList[1]}";
        mins = int.parse(fullMin);
        minText = fullMin;
      }

      if (myList[6] == "0") {
        secs = int.parse(myList[1]);
      } else {
        String fullSec = "${myList[5]}${myList[6]}";
        secs = int.parse(fullSec);
      }
    }

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          isStarted = true;
          //new
          isBeginning = true;
          if (secs == 0 && mins == 0) {
            isStarted = false;
            timer.cancel();
            //new
            isTimeUp = true;
          } else if (secs == 0) {
            if (mins > 0) {
              mins--;
              secs = 59;
            }
            minText = mins < 10 ? "0$mins" : "$mins";
            secText = "59";
          } else {
            secs--;
            secText = secs < 10 ? "0$secs" : "$secs";
          }
        });
      },
    );
  }

  void isVictoryOrNo() {
    final cubit = context.read<SettingsCubit>();

    if (cubit.state.team1Points >= cubit.state.pointsToWin ||
        cubit.state.team2Points >= cubit.state.pointsToWin) {
      if (cubit.state.team1Points >
          cubit.state.pointsToWinMargin - 1 + cubit.state.team2Points) {
        setState(() {
          isSecondPlayerVictory = false;
          isFirstPlayerVictory = true;
        });

        _startFirstConfetti();
      } else if (cubit.state.team2Points >
          cubit.state.pointsToWinMargin - 1 + cubit.state.team1Points) {
        setState(() {
          isFirstPlayerVictory = false;
          isSecondPlayerVictory = true;
        });

        _startSecondConfetti();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter1 = TextPainter(
                    text: TextSpan(
                      text: state.team1Name,
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
                      text: state.team2Name,
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
                              onVerticalDragEnd: (details) {
                                if (_startVerticalDragDetails != null) {
                                  final double verticalDistance =
                                      details.velocity.pixelsPerSecond.dy;

                                  if (verticalDistance > 0) {
                                    decreaceCounters(1, context);
                                  } else {
                                    increaceCounters(1, context);
                                  }
                                }

                                isVictoryOrNo();
                              },
                              child: Container(
                                color: state.team1Color,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.state.team1Name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        state.team1Points.toString(),
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
                              onVerticalDragEnd: (details) {
                                if (_startVerticalDragDetails != null) {
                                  final double verticalDistance =
                                      details.velocity.pixelsPerSecond.dy;
                                  if (verticalDistance > 0) {
                                    decreaceCounters(2, context);
                                  } else {
                                    increaceCounters(2, context);
                                  }
                                }
                                isVictoryOrNo();
                              },
                              child: Container(
                                color: cubit.state.team2Color,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.state.team2Name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        cubit.state.team2Points.toString(),
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
                      state.roundsToWin == 0
                          ? Container()
                          : Positioned(
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
                                            if (state.roundsToWin ==
                                                state.team1WonRounds) {
                                              return;
                                            } else {
                                              cubit.incrementTeam1WonRounds();
                                            }
                                          },
                                          child: Text(
                                            state.team1WonRounds.toString(),
                                            style: TextStyle(
                                              color: state.team1Color,
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
                                            if (state.roundsToWin ==
                                                state.team2WonRounds) {
                                              return;
                                            } else {
                                              cubit.incrementTeam2WonRounds();
                                            }
                                          },
                                          child: Text(
                                            state.team2WonRounds.toString(),
                                            style: TextStyle(
                                              color: state.team2Color,
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
                      cubit.state.timer == "00 : 00"
                          ? Positioned(
                              top: MediaQuery.of(context).size.height / 2 - 35,
                              left: MediaQuery.of(context).size.width / 2 - 35,
                              child: Material(
                                color: Colors.transparent,
                                shape: CircleBorder(),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      if (state.roundsToWin >= 1) {
                                        isExpandedReset = true;
                                        isFirstPlayerVictory = false;
                                        isSecondPlayerVictory = false;
                                      } else {
                                        cubit.resetTeamsPoints();
                                        isFirstPlayerVictory = false;
                                        isSecondPlayerVictory = false;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.refresh_rounded,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
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
                                    isStarted == false
                                        ? IconButton(
                                            onPressed: () {
                                              if (isTimeUp) {
                                                return;
                                              } else {
                                                _startCountDown(context);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.play_arrow_rounded,
                                              size: 50,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              timer!.cancel();
                                              setState(() {
                                                isStarted = false;
                                                isResume = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.pause,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                          ),
                                    const SizedBox(width: 3),
                                    Text(
                                      isBeginning == false
                                          ? state.timer
                                          : isTimeUp
                                              ? "TIME UP"
                                              : "$minText : $secText",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isTimeUp = false;
                                          isResume = false;
                                          isBeginning = false;
                                          log("that's it");
                                          log(state.timer);
                                          _startCountDown;

                                          if (state.roundsToWin == 0) {
                                            cubit.resetTeamsPoints();
                                            isFirstPlayerVictory = false;
                                            isSecondPlayerVictory = false;
                                          } else {
                                            isExpandedReset = true;
                                            isFirstPlayerVictory = false;
                                            isSecondPlayerVictory = false;
                                          }
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
                      isExpandedReset == true
                          ? Positioned(
                              child: Container(
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          cubit.resetTeamsPoints();
                                          setState(() {
                                            isExpandedReset = false;
                                            isTimeUp = false;
                                            isResume = false;
                                            isBeginning = false;
                                            _startCountDown;
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Text(
                                              "Reset point",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(color: Colors.grey),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          cubit.resetMatch();
                                          setState(() {
                                            isExpandedReset = false;

                                            isTimeUp = false;

                                            isResume = false;
                                            isBeginning = false;

                                            _startCountDown;
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Text(
                                              "Reset match",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
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
                      // Positioned(
                      //   top: MediaQuery.of(context).size.width / 2.2,
                      //   left: MediaQuery.of(context).size.width / 2,
                      //   child: MyConfetti(
                      //     confettiController: _confettiController1,
                      //   ),
                      // ),
                      // Positioned(
                      //   top: MediaQuery.of(context).size.height / 1.4,
                      //   left: MediaQuery.of(context).size.width / 2,
                      //   child: MyConfetti(
                      //     confettiController: _confettiController2,
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
              state.isInstruction == true ? Instruction() : Container(),
            ],
          );
        },
      ),
    );
  }
}
