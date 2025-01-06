import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/settings_cubit/settings_cubit.dart';
import 'package:share_plus/share_plus.dart';
import '../../home/home.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     log(cubit.state.isSave.toString());
      //   },
      //   backgroundColor: cubit.state.team1Color,
      //   child: Icon(
      //     Icons.question_mark_rounded,
      //   ),
      // ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
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
                          cubit.updateIsSave(true);
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
                          widget: CounterFromOne(
                            onIncrementTap: cubit.incrementPointsToWin,
                            onDecrementTap: cubit.decrementPointsToWin,
                            counter: state.pointsToWin,
                          ),
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
                          widget: CounterFromOne(
                            onIncrementTap: cubit.incrementPointsToWinMargin,
                            onDecrementTap: cubit.decrementPointsToWinMargin,
                            counter: state.pointsToWinMargin,
                          ),
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
                          widget: CounterFromZero(
                            onIncrementTap: cubit.incrementRoundsToWin,
                            onDecrementTap: cubit.decrementRoundsToWin,
                            counter: state.roundsToWin,
                          ),
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
                          widget: CounterFromOne(
                            onIncrementTap:
                                cubit.incrementIncrementPointsPerTap,
                            onDecrementTap:
                                cubit.decrementIncrementPointsPerTap,
                            counter: state.incrementPerTap,
                          ),
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
                              child: InkWell(
                                onTap: () async {
                                  final result = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) => MyTimerBottomBar(),
                                  );

                                  if (result != null && mounted) {
                                    cubit.updateTeam1Timer(result);
                                  }
                                },
                                child: Text(
                                  state.timer,
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
                              onChanged: (value) =>
                                  cubit.updateTeamName(value, 1),
                              controller: firstNameController,
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
                          widget: ColorPickerWidget(
                            color: state.team1Color,
                            pickerColor: state.team1Color,
                            onColorChanged: (value) =>
                                cubit.updateTeamColor(value, 1),
                            startColor: state.team1Color,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                        Field(
                          text: "Points",
                          icon: Icon(
                            Icons.emoji_events,
                            size: 25,
                            color: Colors.black,
                          ),
                          widget: CounterFromZero(
                            onIncrementTap: cubit.incrementTeam1Points,
                            onDecrementTap: cubit.decrementTeam1Points,
                            counter: state.team1Points,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          height: 1,
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
                              onChanged: (value) =>
                                  cubit.updateTeamName(value, 2),
                              controller: secondNameController,
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
                          widget: ColorPickerWidget(
                            color: state.team2Color,
                            pickerColor: state.team2Color,
                            onColorChanged: (value) =>
                                cubit.updateTeamColor(value, 2),
                            startColor: state.team2Color,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                        Field(
                          text: "Points",
                          icon: Icon(
                            Icons.emoji_events,
                            size: 25,
                            color: Colors.black,
                          ),
                          widget: CounterFromZero(
                            onIncrementTap: cubit.incrementTeam2Points,
                            onDecrementTap: cubit.decrementTeam2Points,
                            counter: state.team2Points,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          height: 1,
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
                            cubit.resetAllSettings();
                          },
                          text: "Reset all settings",
                          icon: Icon(
                            Icons.restore_page_outlined,
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
                          onTap: () {
                            context
                                .read<SettingsCubit>()
                                .updateIsInstruction(true);
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
                          onTap: () {
                            const String appLink =
                                "https://web.telegram.org/k/#@flutternood";
                            Share.share("Check out this amazing app: $appLink");
                          },
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
            );
          },
        ),
      ),
    );
  }
}
