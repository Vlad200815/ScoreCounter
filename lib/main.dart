import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/team_1_cubit/team1_cubit.dart';
import 'package:score_counter/features/blocs/update_bool_cubit/update_bool_cubit.dart';
import 'package:score_counter/features/home/view/home_screen.dart';
import 'package:score_counter/features/settings/settings.dart';
import 'package:score_counter/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateBoolCubit(),
        ),
        BlocProvider(
          create: (context) => Team1Cubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
