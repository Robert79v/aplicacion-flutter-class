import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pmsn20252/utils/value_listener.dart';
import 'package:pmsn20252/widgets/home_content_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;

  double toolbarOpacity = 1.0;

   @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset <= 80) {
          toolbarOpacity = (80 - _scrollController.offset) / 80;
        } else {
          toolbarOpacity = 0;
        }
      });
    });
    super.initState();
  }

  static const List<Widget> _pages = <Widget>[
    HomeContent(),
    Center(child: Text("Likes", style: TextStyle(fontSize: 24))),
    Center(child: Text("Search", style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars App"),
        actions: [
          ValueListenableBuilder(
            valueListenable:  ValueListener.isDark,
            builder: (context, value, child) {
              return  value
              ? IconButton(icon: Icon(Icons.sunny), onPressed: () {
                  ValueListener.isDark.value = false;
                },)
              : IconButton(icon: Icon(Icons.nightlight), onPressed: () {
                  ValueListener.isDark.value = true;
                },);
            },
          ),
        ],
      ),
      drawer: const Drawer(),

      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
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
              activeColor: const Color.fromARGB(255, 255, 255, 255),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
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
      ),
    );
  }
}
