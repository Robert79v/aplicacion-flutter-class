import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B0C10), // 👈 Negro espacial
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF1B6CA8), // Azul Jedi
        onPrimary: Colors.white,
        secondary: Color(0xFFE74C3C), // Rojo Sith
        onSecondary: Colors.white,
        error: Color(0xFFE74C3C), 
        onError: Colors.white,
        surface: Color(0xFF343A40), // Gris metálico oscuro
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B0C10), // Azul Jedi
        foregroundColor: Colors.white, // Texto/íconos
        elevation: 4,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0B0C10), // Negro espacial
        selectedItemColor: Color(0xFF1B6CA8), // Azul Jedi
        unselectedItemColor: Colors.grey, // Ítems apagados
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 33, 133, 248), // 👈 Gris metálico claro
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF1B6CA8), // Azul Jedi
        onPrimary: Colors.white,
        secondary: Color(0xFFE74C3C), // Rojo Sith
        onSecondary: Colors.white,
        error: Color(0xFFE74C3C),
        onError: Colors.white,
        surface: Color(0xFFE5E5E5), // Gris muy claro
        onSurface: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 19, 109, 213), // Azul Jedi
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFBAB7B7), // Gris metálico claro
        selectedItemColor: Color(0xFF1B6CA8), // Azul Jedi
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}
