import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          //Is Sace these settings or not
          isSave: false,
          //Match settings
          pointsToWin: 1,
          pointsToWinMargin: 1,
          roundsToWin: 0,
          incrementPerTap: 1,
          timer: "00:00",
          //Team 1
          team1Name: "Team 1",
          team1Color: Colors.redAccent,
          team1Points: 0,
          //Team 2
          team2Name: "Team 2",
          team2Color: Colors.lightBlue,
          team2Points: 0,
          //Appearance
          appearance: 0,
        ));

  //Match settins
  void incrementPointsToWin() {
    emit(state.copyWith(pointsToWin: state.pointsToWin + 1));
  }

  void decrementPointsToWin() {
    if (state.pointsToWin < 2) {
      return;
    } else {
      emit(state.copyWith(pointsToWin: state.pointsToWin - 1));
    }
  }

  void incrementPointsToWinMargin() {
    emit(state.copyWith(pointsToWinMargin: state.pointsToWinMargin + 1));
  }

  void decrementPointsToWinMargin() {
    if (state.pointsToWinMargin < 2) {
      return;
    } else {
      emit(state.copyWith(pointsToWinMargin: state.pointsToWinMargin - 1));
    }
  }

  void incrementRoundsToWin() {
    emit(state.copyWith(roundsToWin: state.roundsToWin + 1));
  }

  void decrementRoundsToWin() {
    if (state.roundsToWin < 1) {
      return;
    } else {
      emit(state.copyWith(roundsToWin: state.roundsToWin - 1));
    }
  }

  void incrementIncrementPointsPerTap() {
    emit(state.copyWith(incrementPerTap: state.incrementPerTap + 1));
  }

  void decrementIncrementPointsPerTap() {
    if (state.incrementPerTap < 2) {
      return;
    } else {
      emit(state.copyWith(incrementPerTap: state.incrementPerTap - 1));
    }
  }

  void updateTeam1Timer(Map<String, int> result) {
    String newTeam1Timer = "00:00";
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
  }

  //Functions for the teams
  void updateTeamName(String newName, int whatTeam) {
    if (whatTeam == 1) {
      emit(state.copyWith(team1Name: newName));
    } else if (whatTeam == 2) {
      emit(state.copyWith(team2Name: newName));
    } else {
      return;
    }
  }

  void updateTeamColor(Color newColor, int whatTeam) {
    if (whatTeam == 1) {
      emit(state.copyWith(team1Color: newColor));
      log("1 Color is changed");
    } else if (whatTeam == 2) {
      emit(state.copyWith(team2Color: newColor));
      log("2 Color is changed");
    } else {
      return;
    }
  }

  //Team 1's counter functions
  void incrementTeam1Points() {
    emit(state.copyWith(team1Points: state.team1Points + 1));
  }

  void decrementTeam1Points() {
    if (state.team1Points < 1) {
      return;
    } else {
      emit(state.copyWith(team1Points: state.team1Points - 1));
    }
  }

  //Team 2's counter functions
  void incrementTeam2Points() {
    emit(state.copyWith(team2Points: state.team2Points + 1));
  }

  void decrementTeam2Points() {
    if (state.team2Points < 1) {
      return;
    } else {
      emit(state.copyWith(team2Points: state.team2Points - 1));
    }
  }

  //Is save every setting or not
  void updateIsSave(bool newIsSave) {
    emit(state.copyWith(isSave: newIsSave));
  }
}
