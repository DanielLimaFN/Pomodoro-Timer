import 'package:flutter/material.dart';
import 'package:pomodoro/pages/Pomodoro.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PomodoroStore>(create: (_) => PomodoroStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Pomodoro(),
      ),
    ),
  );
}
