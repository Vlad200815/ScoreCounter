import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/cubit/update_bool_cubit.dart';
import 'package:score_counter/features/settings/widgets/my_bottom_sheet_bar_appearance.dart';
import 'package:score_counter/features/settings/widgets/my_timer_bottom_bar.dart';
import '../../home/home.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedTime = "00:00";

  void showTimerBottomSheet() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => MyTimerBottomBar(),
    );

    // If the user selects a time, update the state
    if (result != null && mounted) {
      if (result["min"] < 10 && result["sec"] < 10) {
        setState(() {
          selectedTime = "0${result['min']} : 0${result['sec']}";
        });
      } else if (result["min"] < 10 && result["sec"] >= 10) {
        setState(() {
          selectedTime = "0${result['min']} : ${result['sec']}";
        });
      } else if (result["min"] >= 10 && result["sec"] < 10) {
        setState(() {
          selectedTime = "${result['min']} : 0${result['sec']}";
        });
      } else {
        setState(() {
          selectedTime = "${result['min']} : ${result['sec']}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Match settings",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Field(
                      text: "Points to win",
                      icon: Icon(
                        Icons.local_police_rounded,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Points to win margin",
                      icon: Icon(
                        Icons.bed_rounded,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Rounds to win",
                      icon: Icon(
                        Icons.emoji_events,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Increment point  per tap",
                      icon: Icon(
                        Icons.add_circle,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      // onTap: () {},
                      text: "Timer",
                      icon: Icon(
                        Icons.timer,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Container(
                        width: 90,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 0.8,
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: showTimerBottomSheet,
                            child: Text(
                              selectedTime,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Team 1",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Field(
                      text: "Name",
                      icon: Icon(
                        Icons.edit,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: SizedBox(
                        width: 70,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Team 1",
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Color",
                      icon: Icon(
                        Icons.palette,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: ColorPickerWidget(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Points",
                      icon: Icon(
                        Icons.bed,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Rounds",
                      icon: Icon(
                        Icons.emoji_events,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Team 2",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Field(
                      text: "Name",
                      icon: Icon(
                        Icons.local_police_rounded,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: SizedBox(
                        width: 70,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Team 2",
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Color",
                      icon: Icon(
                        Icons.palette,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: ColorPickerWidget(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Points",
                      icon: Icon(
                        Icons.bed,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Rounds",
                      icon: Icon(
                        Icons.emoji_events,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Counter(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Appearance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    MyBottomSheetBarAppearance(
                      child: Field(
                        text: "Preset colors",
                        icon: Icon(
                          Icons.palette,
                          size: 25,
                          color: Colors.black,
                        ),
                        widget: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Others",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Field(
                      onTap: () {
                        context.read<UpdateBoolCubit>().updateBool(true);
                        Navigator.pop(context);
                      },
                      text: "How to use",
                      icon: Icon(
                        Icons.question_mark,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Container(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Rate app",
                      icon: Icon(
                        Icons.star,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Container(),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                    Field(
                      text: "Share app",
                      icon: Icon(
                        Icons.share,
                        size: 25,
                        color: Colors.black,
                      ),
                      widget: Container(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
