part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    //isSave
    required this.isSave,
    //Match Settings
    required this.pointsToWin,
    required this.pointsToWinMargin,
    required this.roundsToWin,
    required this.incrementPerTap,
    required this.timer,
    //Team 1
    required this.team1Name,
    required this.team1Color,
    required this.team1Points,
    //Team 2
    required this.team2Name,
    required this.team2Color,
    required this.team2Points,
  });

  //isSave
  final bool isSave;
  //Match settings
  final int pointsToWin;
  final int pointsToWinMargin;
  final int roundsToWin;
  final int incrementPerTap;
  final String timer;
  //Team 1
  final String team1Name;
  final Color team1Color;
  final int team1Points;
  //Team 2
  final String team2Name;
  final Color team2Color;
  final int team2Points;

  SettingsState copyWith({
    //isSave
    bool? isSave,
    //Match settings
    int? pointsToWin,
    int? pointsToWinMargin,
    int? roundsToWin,
    int? incrementPerTap,
    String? timer,
    //Team 1
    String? team1Name,
    Color? team1Color,
    int? team1Points,
    //Team 2
    String? team2Name,
    Color? team2Color,
    int? team2Points,
  }) {
    return SettingsState(
      //isSave
      isSave: isSave ?? this.isSave,
      //Match settings
      pointsToWin: pointsToWin ?? this.pointsToWin,
      pointsToWinMargin: pointsToWinMargin ?? this.pointsToWinMargin,
      roundsToWin: roundsToWin ?? this.roundsToWin,
      incrementPerTap: incrementPerTap ?? this.incrementPerTap,
      timer: timer ?? this.timer,
      //Team 1
      team1Name: team1Name ?? this.team1Name,
      team1Color: team1Color ?? this.team1Color,
      team1Points: team1Points ?? this.team1Points,
      //Team 2
      team2Name: team2Name ?? this.team2Name,
      team2Color: team2Color ?? this.team2Color,
      team2Points: team2Points ?? this.team2Points,
    );
  }

  @override
  List<Object> get props => [
        //isSave
        isSave,
        //Match settings
        pointsToWin,
        pointsToWinMargin,
        roundsToWin,
        incrementPerTap,
        timer,
        //Team 1
        team1Name,
        team1Color,
        team1Points,
        //Team 2
        team2Name,
        team2Color,
        team2Points,
      ];
}
