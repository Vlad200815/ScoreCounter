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
  // int counter1 = 0;
  // int counter2 = 0;

  // int firstPlayerWonRounds = 0;
  // int secondPlayerWonRounds = 0;

  String firstTeamName = "Team 1";
  String secondTeamName = "Team 2";

  Offset? _startVerticalDragDetails;

  late ConfettiController _confettiController1;
  late ConfettiController _confettiController2;

  bool isFirstPlayerVictory = false;
  bool isSecondPlayerVictory = false;

  bool isExpandedReset = false;

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

  void increaceCounters(int counterIndex, BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    if (counterIndex == 1) {
      // setState(() {
      //   counter1++;
      // });
      cubit.incrementTeam1Points();
    } else {
      cubit.incrementTeam2Points();
      // setState(() {
      //   counter2++;
      // });
    }
  }

  void decreaceCounters(int counterIndex, BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    if (counterIndex == 1) {
      cubit.decrementTeam1Points();
      // setState(() {
      //   counter1--;
      // });
    } else {
      cubit.decrementTeam2Points();
      // setState(() {
      //   counter2--;
      // });
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
    if (mounted) {
      setState(() {
        isFirstPlayerVictory = false;
      });
    }
  }

  Future<void> _triggerDelayActionOfSecondPlayer() async {
    await Future.delayed(Duration(milliseconds: 2500));
    if (mounted) {
      setState(() {
        isSecondPlayerVictory = false;
      });
    }
  }

  Future<void> isVictoryOrNo() async {
    final cubit = context.read<SettingsCubit>();
    if (cubit.state.team1Points > cubit.state.team2Points) {
      setState(() {
        isFirstPlayerVictory = true;
      });

      _startFirstConfetti();
      await _triggerDelayActionOfFirstPlayer();
    } else if (cubit.state.team2Points > cubit.state.team1Points) {
      setState(() {
        isSecondPlayerVictory = true;
      });

      _startSecondConfetti();
      await _triggerDelayActionOfSecondPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     log(cubit.state.isSave.toString());
      //   },
      // ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
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
                                    decreaceCounters(1, context);
                                  } else {
                                    increaceCounters(1, context);
                                  }
                                }
                                //TODO: imporove victory logic here
                                await isVictoryOrNo();
                              },
                              child: Container(
                                //TODO: think how to fix the thing with this red colour
                                color: state.isSave == true
                                    ? state.team1Color
                                    : Colors.redAccent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.isSave == true
                                            ? cubit.state.team1Name
                                            : firstTeamName,
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
                              onVerticalDragEnd: (details) async {
                                if (_startVerticalDragDetails != null) {
                                  final double verticalDistance =
                                      details.velocity.pixelsPerSecond.dy;
                                  if (verticalDistance > 0) {
                                    decreaceCounters(2, context);
                                  } else {
                                    increaceCounters(2, context);
                                  }
                                }
                                //TODO: imporove victory logic here
                                await isVictoryOrNo();
                              },
                              child: Container(
                                //TODO: the same thing with color which is located a bit higher
                                color: cubit.state.isSave == true
                                    ? cubit.state.team2Color
                                    : Colors.lightBlue,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.state.isSave == true
                                            ? cubit.state.team2Name
                                            : secondTeamName,
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
                            cubit.updateIsSave(false);
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
                                            // setState(() {
                                            //   firstPlayerWonRounds++;
                                            // });
                                            cubit.incrementTeam1WonRounds();
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
                                            cubit.incrementTeam2WonRounds();
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
                                    if (state.roundsToWin >= 1) {
                                      //TODO: replace setState with cubit
                                      setState(() {
                                        isExpandedReset = true;
                                      });
                                    } else {
                                      cubit.resetTeamsPoints();
                                    }
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
                                      state.timer,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    IconButton(
                                      onPressed: () {
                                        //TODO: replace the setState thing into cubit
                                        if (state.roundsToWin == 0) {
                                          cubit.resetTeamsPoints();
                                        } else {
                                          setState(() {
                                            isExpandedReset = true;
                                          });
                                        }
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
                                      child: InkWell(
                                        onTap: () {
                                          cubit.resetTeamsPoints();
                                          setState(() {
                                            isExpandedReset = false;
                                          });
                                        },
                                        child: Container(
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
                                          });
                                        },
                                        child: Container(
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
              state.isInstruction == true ? Instruction() : Container(),
            ],
          );
        },
      ),
    );
  }
}
