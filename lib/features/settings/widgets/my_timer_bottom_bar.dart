import 'package:flutter/material.dart';

class MyTimerBottomBar extends StatefulWidget {
  const MyTimerBottomBar({super.key});

  @override
  State<MyTimerBottomBar> createState() => _MyTimerBottomBarState();
}

class _MyTimerBottomBarState extends State<MyTimerBottomBar> {
  int selectedMin = 0;
  int selectedSec = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      {
                        "min": 0,
                        "sec": 0,
                      },
                    );
                  },
                  child: Text(
                    "Set timer",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      {
                        "min": selectedMin,
                        "sec": selectedSec,
                      },
                    );
                  },
                  child: Text(
                    "Select",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ListWheelScrollView.useDelegate(
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedMin = value;
                        });
                      },
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Center(
                              child: index == 0
                                  ? Text(
                                      index.toString(),
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  : selectedMin != index
                                      ? Text(
                                          index.toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        )
                                      : Text(
                                          index.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text("min"),
                  SizedBox(
                    width: 100,
                    child: ListWheelScrollView.useDelegate(
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedSec = value;
                        });
                      },
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index) {
                          return Center(
                            child: index == 0
                                ? Text(
                                    index.toString(),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                : selectedSec != index
                                    ? Text(
                                        index.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    : Text(
                                        index.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text("sec"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
