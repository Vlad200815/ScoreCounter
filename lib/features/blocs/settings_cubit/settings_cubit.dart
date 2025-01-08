import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          //Match settings
          pointsToWin: 1,
          pointsToWinMargin: 1,
          roundsToWin: 0,
          incrementPerTap: 1,
          timer: "00 : 00",
          //Team 1
          team1Name: "Team 1",
          team1Color: Colors.redAccent,
          team1Points: 0,
          team1WonRounds: 0,
          //Team 2
          team2Name: "Team 2",
          team2Color: Colors.lightBlue,
          team2Points: 0,
          team2WonRounds: 0,
          //Other -> isInstruction
          isInstruction: false,
        )) {
    _loadSettings();
  }

  //Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    // Load each setting from SharedPreferences or default value
    final pointsToWin = prefs.getInt("pointsToWin") ?? 1;
    final pointsToWinMargin = prefs.getInt("pointsToWinMargin") ?? 1;
    final roundsToWin = prefs.getInt("roundsToWin") ?? 0;
    final incrementPerTap = prefs.getInt("incrementsPerTap") ?? 1;
    final timer = prefs.getString("timer") ?? "00 : 00";
    final team1Name = prefs.getString("team1Name") ?? "Team 1";
    final team1Color = prefs.getString("team1Color") ?? "#F44336";
    final team1Points = prefs.getInt("team1Points") ?? 0;
    final team1WonRounds = prefs.getInt("team1WonRounds") ?? 0;
    final team2Name = prefs.getString("team2Name") ?? "Team 2";
    final team2Color = prefs.getString("team2Color") ?? "#03A9F4";
    final team2Points = prefs.getInt("team2Points") ?? 0;
    final team2WonRounds = prefs.getInt("team2WonRounds") ?? 0;
    final isInstruction = prefs.getBool("isInstruction") ?? false;

    emit(state.copyWith(
      pointsToWin: pointsToWin,
      pointsToWinMargin: pointsToWinMargin,
      roundsToWin: roundsToWin,
      incrementPerTap: incrementPerTap,
      team1Name: team1Name,
      team1Color: _colorFromHex(team1Color),
      team1Points: team1Points,
      team1WonRounds: team1WonRounds,
      team2Name: team2Name,
      team2Color: _colorFromHex(team2Color),
      team2Points: team2Points,
      team2WonRounds: team2WonRounds,
      isInstruction: isInstruction,
      timer: timer,
    ));
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('pointsToWin', state.pointsToWin);
    prefs.setInt('pointsToWinMargin', state.pointsToWinMargin);
    prefs.setInt('roundsToWin', state.roundsToWin);
    prefs.setInt('incrementPerTap', state.incrementPerTap);
    prefs.setString('team1Name', state.team1Name);
    prefs.setString('team1Color', _colorToHex(state.team1Color));
    prefs.setInt('team1Points', state.team1Points);
    prefs.setInt('team1WonRounds', state.team1WonRounds);
    prefs.setString('team2Name', state.team2Name);
    prefs.setString('team2Color', _colorToHex(state.team2Color));
    prefs.setInt('team2Points', state.team2Points);
    prefs.setInt('team2WonRounds', state.team2WonRounds);
    prefs.setBool('isInstruction', state.isInstruction);
    prefs.setString('timer', state.timer);
  }

  // Helper methods to convert Color to Hex and vice versa
  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add alpha if not present
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  String _colorToHex(Color color) {
    return "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
  }

  //Match settins
  void incrementPointsToWin() {
    emit(
      state.copyWith(pointsToWin: state.pointsToWin + 1),
    );
    _saveSettings();
  }

  void decrementPointsToWin() {
    if (state.pointsToWin < 2) {
      return;
    } else {
      emit(state.copyWith(pointsToWin: state.pointsToWin - 1));
      _saveSettings();
    }
  }

  void incrementPointsToWinMargin() {
    emit(state.copyWith(pointsToWinMargin: state.pointsToWinMargin + 1));
    _saveSettings();
  }

  void decrementPointsToWinMargin() {
    if (state.pointsToWinMargin < 2) {
      return;
    } else {
      emit(state.copyWith(pointsToWinMargin: state.pointsToWinMargin - 1));
      _saveSettings();
    }
  }

  void incrementRoundsToWin() {
    emit(state.copyWith(roundsToWin: state.roundsToWin + 1));
    _saveSettings();
  }

  void decrementRoundsToWin() {
    if (state.roundsToWin < 1) {
      return;
    } else {
      emit(state.copyWith(roundsToWin: state.roundsToWin - 1));
      _saveSettings();
    }
  }

  void incrementIncrementPointsPerTap() {
    emit(state.copyWith(incrementPerTap: state.incrementPerTap + 1));
    _saveSettings();
  }

  void decrementIncrementPointsPerTap() {
    if (state.incrementPerTap < 2) {
      return;
    } else {
      emit(state.copyWith(incrementPerTap: state.incrementPerTap - 1));
      _saveSettings();
    }
  }

  void updateTimer(Map<String, int> result) {
    String newTeam1Timer = "00 : 00";
    if (result["min"]! < 10 && result["sec"]! < 10) {
      newTeam1Timer = "0${result['min']} : 0${result['sec']}";
    } else if (result["min"]! < 10 && result["sec"]! >= 10) {
      newTeam1Timer = "0${result['min']} : ${result['sec']}";
    } else if (result["min"]! >= 10 && result["sec"]! < 10) {
      newTeam1Timer = "${result['min']} : 0${result['sec']}";
    } else {
      newTeam1Timer = "${result['min']} : ${result['sec']}";
    }
    log("newTime: $newTeam1Timer");
    emit(state.copyWith(timer: newTeam1Timer));
    _saveSettings();
  }

  //Functions for the teams
  void updateTeamName(String newName, int whatTeam) {
    if (whatTeam == 1) {
      emit(state.copyWith(team1Name: newName));
      _saveSettings();
    } else if (whatTeam == 2) {
      emit(state.copyWith(team2Name: newName));
      _saveSettings();
    } else {
      return;
    }
  }

  void updateTeamColor(Color newColor, int whatTeam) {
    if (whatTeam == 1) {
      emit(state.copyWith(team1Color: newColor));
      log("1 Color is changed");
      _saveSettings();
    } else if (whatTeam == 2) {
      emit(state.copyWith(team2Color: newColor));
      log("2 Color is changed");
      _saveSettings();
    } else {
      return;
    }
  }

  //Team 1's counter functions
  void incrementTeam1Points() {
    emit(
        state.copyWith(team1Points: state.team1Points + state.incrementPerTap));
    _saveSettings();
  }

  void decrementTeam1Points() {
    if (state.team1Points < 1) {
      return;
    } else {
      emit(state.copyWith(
          team1Points: state.team1Points - state.incrementPerTap));
      _saveSettings();
    }
  }

  void incrementTeam1WonRounds() {
    if (state.roundsToWin == state.team1WonRounds) {
      return;
    } else {
      emit(state.copyWith(team1WonRounds: state.team1WonRounds + 1));
      _saveSettings();
    }
  }

  void decrementTeam1WonRounds() {
    if (state.team1WonRounds < 1) {
      return;
    } else {
      emit(state.copyWith(team1WonRounds: state.team1WonRounds - 1));
      _saveSettings();
    }
  }

  //Team 2's counter functions
  void incrementTeam2Points() {
    emit(
        state.copyWith(team2Points: state.team2Points + state.incrementPerTap));
    _saveSettings();
  }

  void decrementTeam2Points() {
    if (state.team2Points < 1) {
      return;
    } else {
      emit(state.copyWith(
          team2Points: state.team2Points - state.incrementPerTap));
      _saveSettings();
    }
  }

  void incrementTeam2WonRounds() {
    if (state.roundsToWin == state.team2WonRounds) {
      return;
    } else {
      emit(state.copyWith(team2WonRounds: state.team2WonRounds + 1));
      _saveSettings();
    }
  }

  void decrementTeam2WonRounds() {
    if (state.team2WonRounds < 1) {
      return;
    } else {
      emit(state.copyWith(team2WonRounds: state.team2WonRounds - 1));
      _saveSettings();
    }
  }

  //Reset all the settings to the basic
  void resetAllSettings() {
    emit(
      state.copyWith(
        pointsToWin: 1,
        pointsToWinMargin: 1,
        roundsToWin: 0,
        incrementPerTap: 1,
        timer: "00 : 00",
        team1Color: Colors.lightBlue,
        team2Color: Colors.redAccent,
        team1Name: "Team 1",
        team2Name: "Team 2",
        team1Points: 0,
        team2Points: 0,
      ),
    );
    _saveSettings();
  }

  //Other -> isInstruction
  void updateIsInstruction(bool newIsInstruction) {
    emit(state.copyWith(isInstruction: newIsInstruction));
    _saveSettings();
  }

  //Functions for home screen which use propertices from this cubit
  void resetTeamsPoints() {
    emit(state.copyWith(team1Points: 0, team2Points: 0));
    _saveSettings();
  }

  void resetMatch() {
    emit(state.copyWith(
      team1Points: 0,
      team2Points: 0,
      team1WonRounds: 0,
      team2WonRounds: 0,
    ));
    _saveSettings();
  }
}
