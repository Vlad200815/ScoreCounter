import 'package:flutter/material.dart';
import 'package:score_counter/screens/home_screen.dart';
import 'package:score_counter/widget/choose_box.dart';
import 'package:score_counter/widget/color_picker.dart';
import 'package:score_counter/widget/counter.dart';
import 'package:score_counter/widget/field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                          child: Text(
                            "10 : 02",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
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
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      16,
                                    ), // Round the top corners
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Back",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 9,
                                          horizontal: 18,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.lightBlue,
                                          secondColor: Colors.redAccent,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 9,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.cyan,
                                          secondColor: Colors.greenAccent,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 9,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.black,
                                          secondColor: Colors.orange,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 9,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.lime,
                                          secondColor: const Color.fromARGB(
                                              255, 59, 111, 61),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 9,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.pink,
                                          secondColor: Colors.deepPurple,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 9,
                                        ),
                                        child: ChooseBox(
                                          firstColor: Colors.deepOrange,
                                          secondColor: Colors.cyanAccent,
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
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
