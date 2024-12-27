import 'package:flutter/material.dart';
import 'package:score_counter/screens/home_screen.dart';
import 'package:score_counter/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
