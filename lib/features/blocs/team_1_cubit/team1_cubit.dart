import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'team1_state.dart';

class Team1Cubit extends Cubit<Team1State> {
  Team1Cubit() : super(Team1Initial());

  void incremetPointsToWin() {
    final currentCounter = (state as PointsToWinState).counter;
    emit(PointsToWinState(counter: currentCounter + 1));
  }

  void decrementPointsToWin() {
    final currentCounter = (state as PointsToWinState).counter;
    emit(PointsToWinState(counter: currentCounter - 1));
  }

  void incremetPointsToWinMargin() {
    final currentCounter = (state as PointsToWinMarginState).counter;
    emit(PointsToWinMarginState(counter: currentCounter + 1));
  }

  void decrementPointsToWinMargin() {
    final currentCounter = (state as PointsToWinMarginState).counter;
    emit(PointsToWinMarginState(counter: currentCounter - 1));
  }

  void incremetRoundsToWin() {
    final currentCounter = (state as RoundsToWinState).counter;
    emit(RoundsToWinState(counter: currentCounter + 1));
  }

  void decrementRoundsToWin() {
    final currentCounter = (state as RoundsToWinState).counter;
    emit(RoundsToWinState(counter: currentCounter - 1));
  }

  //already updated!!!
  void updateTeam1Timer() {
    final currentTimer = (state as TimerState).timer;
    emit(TimerState(timer: currentTimer));
  }
}
