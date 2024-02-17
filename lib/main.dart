import 'package:flutter/material.dart';
import 'package:guc_gpa_calculator/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 83, 151),
            secondary: Colors.blueAccent,
            error: Colors.red,
            surface: Colors.white,
            onSurface: Colors.black,
            primary: const Color.fromARGB(255, 1, 83, 151),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onBackground: Colors.black,
            background: Colors.white,
            onError: Colors.white,
            brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
