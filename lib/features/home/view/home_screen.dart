import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/cubit/update_bool_cubit.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter1 = 0;
  int counter2 = 0;
  Offset? _startVerticalDragDetails;
  bool test = false;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<UpdateBoolCubit, bool>(
        builder: (context, state) {
          log(context.read<UpdateBoolCubit>().state.toString());
          return Stack(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onVerticalDragStart: (details) {
                            _startVerticalDragDetails = details.globalPosition;
                          },
                          onVerticalDragEnd: (details) {
                            if (_startVerticalDragDetails != null) {
                              final double verticalDistance =
                                  details.velocity.pixelsPerSecond.dy;

                              if (verticalDistance > 0) {
                                decreaceCounters(1);
                              } else {
                                increaceCounters(1);
                              }
                            }
                          },
                          child: Container(
                            color: Colors.lightBlue,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Team 1",
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
                            _startVerticalDragDetails = details.globalPosition;
                          },
                          onVerticalDragEnd: (details) {
                            if (_startVerticalDragDetails != null) {
                              final double verticalDistance =
                                  details.velocity.pixelsPerSecond.dy;
                              if (verticalDistance > 0) {
                                decreaceCounters(2);
                              } else {
                                increaceCounters(2);
                              }
                            }
                          },
                          child: Container(
                            color: Colors.redAccent,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Team 2",
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
                    top: 40,
                    child: Transform.rotate(
                      angle: 90 * 3.14159265359 / 180,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/settings");
                        },
                        child: Image.asset(
                          "assets/setting.png",
                          color: Colors.white,
                          scale: 12,
                        ),
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
                              child: Text(
                                "0",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
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
                              child: Text(
                                "0",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
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
                            onPressed: () {},
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.refresh_rounded,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              state == true ? Instruction() : Container(),
            ],
          );
        },
      ),
    );
  }
}
