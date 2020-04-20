import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmylife/providers/save_data_provider.dart';
import 'package:workmylife/screens/intro_screen.dart';

void main() => runApp(WorkMyLifeApp());

class WorkMyLifeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SaveData>(
      create: (context) => SaveData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Work My Life",
          home: Material(
            child: IntroScreen(),
          )),
    );
  }
}
