import 'package:app/screens/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the color scheme from the design reference
    const primaryColor = Color(0xFF2563EB);
    const backgroundLight = Color(0xFFF8FAFC);
    const backgroundDark = Color(0xFF020617);

    // Create light and dark themes
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        background: backgroundLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        background: backgroundDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ),
    );

    return MaterialApp(
      title: 'Task Management App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark
      home: const TaskListScreen(),
    );
  }
}
