import 'package:flutter/material.dart';
import 'package:flutter_apps/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F1),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF376B4D),
          onPrimary: Colors.white,
          secondary: Color(0xFFF5C542),
          onSecondary: Color(0xFF292D32),
          error: Color(0xFFE85D4A),
          onError: Colors.white,
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF292D32),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF376B4D),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        fontFamily: 'Montserrat',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home-page': (context) => const HomePage(),
      },
    );
  }
}
