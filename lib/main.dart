import 'package:flutter/material.dart';
import 'package:pmsn20252/screens/favorite_screen.dart';
import 'package:pmsn20252/screens/planet_screen.dart';
import 'package:pmsn20252/screens/starship_screen.dart';
import 'package:pmsn20252/screens/home_screen.dart';
import 'package:pmsn20252/screens/login_screen.dart';
import 'package:pmsn20252/screens/register_screen.dart';
import 'package:pmsn20252/utils/theme_app.dart';
import 'package:pmsn20252/screens/list_movies.dart';
import 'package:pmsn20252/utils/value_listener.dart';
import 'package:pmsn20252/widgets/heroes_content_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDark,
      builder: (context, value, _) {
        return MaterialApp(
          theme: value ? ThemeApp.darkTheme() : ThemeApp.lightTheme(),
          routes: {
            "/home" : (context) => HomeScreen(),
            "/register" : (context) => RegisterScreen(),
            "/listdb" : (context) => const ListMovies(),
            "/starship" : (context) => const StarshipScreen(),
            "/planet" : (context) => const PlanetDetailScreen(),
            "/favorite" : (context) => const FavoriteScreen(),
            "/heroes" : (context) => const HeroesContent(),
          },
          title: 'MaterialApp',
          home: LoginScreen(),
        );
      }
    );
  }
}