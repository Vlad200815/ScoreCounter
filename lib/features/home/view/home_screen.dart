import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/cubit/update_bool_cubit.dart';

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
              // BackdropFilter(
              //   filter: ImageFilter.blur(
              //     sigmaX: 3,
              //     sigmaY: 3,
              //   ),

              state == true
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: RichText(
                              text: TextSpan(
                                text: "Tap ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                                children: [
                                  TextSpan(
                                    text: "or ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Swipe Up ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "to increase point",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/instruction/click.png",
                                color: Colors.white,
                                scale: 3,
                              ),
                              Image.asset(
                                "assets/instruction/swipe_up.png",
                                color: Colors.white,
                                scale: 3,
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 1.6),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: RichText(
                              text: TextSpan(
                                text: "Swipe down ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                                children: [
                                  TextSpan(
                                    text: "to decrease point",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 12),
                          Image.asset(
                            "assets/instruction/swipe_down.png",
                            color: Colors.white,
                            scale: 3,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 30),
                          InkWell(
                            onTap: () {
                              context.read<UpdateBoolCubit>().updateBool(false);
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: 130,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "OK, I got it!",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
