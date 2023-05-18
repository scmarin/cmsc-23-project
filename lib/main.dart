import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/todays_entry_provider.dart';
import 'screens/TodaysEntryRoute.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodaysEntryProvider())],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {"/": (context) => const TodaysEntryRoute()},
    );
  }
}
