import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pmsn20252/screens/favorite_screen.dart';
import 'package:pmsn20252/screens/menu_screen.dart';
import 'package:pmsn20252/utils/value_listener.dart';
import 'package:pmsn20252/widgets/heroes_content_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;
  double toolbarOpacity = 1.0;

  // Página extra para "Explorar Héroes"
  Widget? _extraPage;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        toolbarOpacity = _scrollController.offset <= 80
            ? (80 - _scrollController.offset) / 80
            : 0;
      });
    });

    _pages = [
      StarWarsMenuScreen(onSelectHeroes: showHeroes),
      FavoriteScreen(),
      Center(child: Text("Search", style: TextStyle(fontSize: 24))),
      Center(child: Text("Profile", style: TextStyle(fontSize: 24))),
    ];
  }

  void showHeroes() {
    setState(() {
      _extraPage = HeroesContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_extraPage != null) {
          // Si estamos en la vista de héroes, cerramos esa vista
          setState(() {
            _extraPage = null;
          });
          return false; // Evitamos salir de HomeScreen
        }
        return true; // Si no hay página extra, sí permite salir (al login)
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Star Wars App"),
          leading: _extraPage != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _extraPage = null; // Regresamos al menú
                    });
                  },
                )
              : null,
          actions: [
            ValueListenableBuilder(
              valueListenable: ValueListener.isDark,
              builder: (context, value, child) {
                return value
                    ? IconButton(
                        icon: const Icon(Icons.sunny),
                        onPressed: () {
                          ValueListener.isDark.value = false;
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.nightlight),
                        onPressed: () {
                          ValueListener.isDark.value = true;
                        },
                      );
              },
            ),
          ],
        ),
        drawer: const Drawer(),
        body: _extraPage ?? _pages[_selectedIndex],
        bottomNavigationBar: _extraPage == null ? _bottomNav() : null,
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.black.withOpacity(0.1),
            color: const Color.fromARGB(255, 225, 219, 219),
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Likes',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
