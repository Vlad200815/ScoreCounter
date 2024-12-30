import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/home/view/home_screen.dart';
import 'package:score_counter/theme/theme.dart';

import 'features/blocs/cubit/update_is_inst_cubit.dart';

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
      home: BlocProvider(
        create: (context) => UpdateIsInstCubit(),
        child: HomeScreen(),
      ),
    );
  }
}
