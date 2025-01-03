part of 'team1_cubit.dart';

sealed class Team1State extends Equatable {
  const Team1State();

  @override
  List<Object> get props => [];
}

final class Team1Initial extends Team1State {}

final class PointsToWinState extends Team1State {
  final int counter;

  const PointsToWinState({required this.counter});
}

final class PointsToWinMarginState extends Team1State {
  final int counter;

  const PointsToWinMarginState({required this.counter});
}

final class RoundsToWinState extends Team1State {
  final int counter;

  const RoundsToWinState({required this.counter});
}

final class IncrementPerTapState extends Team1State {
  final int counter;

  const IncrementPerTapState({required this.counter});
}

final class TimerState extends Team1State {
  final String timer;

  const TimerState({required this.timer});
}
