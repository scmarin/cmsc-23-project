import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/StudentProvider.dart';
import 'screens/StudentListRoute.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => StudentProvider(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Admin View [View All Student]",
        initialRoute: "/",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => StudentListRoute(),
        });
  }
}
