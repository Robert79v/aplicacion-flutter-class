import 'package:flutter/material.dart';
import 'package:pmsn20252/models/troop_model.dart';

class TroopDetailsPage extends StatefulWidget {
  final TroopModel troop;

  const TroopDetailsPage(this.troop, {Key? key}) : super(key: key);

  @override
  _TroopDetailsPageState createState() => _TroopDetailsPageState();
}

class _TroopDetailsPageState extends State<TroopDetailsPage> {
  final double appBarHeight = 80.0;
  late final ScrollController _scrollController;
  double toolbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        toolbarOpacity = (_scrollController.offset <= appBarHeight)
            ? (appBarHeight - _scrollController.offset) / appBarHeight
            : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 46, 26, 71), Color(0xFFEE3474)],
            begin: Alignment(0.3, -1),
            end: Alignment(-0.8, 1),
          ),
        ),
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: appBarHeight),
              children: [
                _TroopDetailsImage(troop: widget.troop),
                _TroopDetailsName(name: widget.troop.name),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                  child: Text(
                    "Personajes legendarios del universo de Star Wars. "
                    "Estas fuerzas alcanzan su máximo poder cuando la luz y la oscuridad se enfrentan en la galaxia.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    const SizedBox(width: 28),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size.fromHeight(54),
                        ),
                        child: const Text(
                          'Add Favourite',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/home');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFE74C3C), Color(0xFFB71C1C)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
                            alignment: Alignment.center,
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
                const SizedBox(height: 28),
              ],
            ),
            SafeArea(
              child: Opacity(
                opacity: toolbarOpacity,
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: Container(height: appBarHeight)),
                    Container(
                      width: appBarHeight,
                      height: appBarHeight,
                      child: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TroopDetailsImage extends StatelessWidget {
  final TroopModel troop;

  const _TroopDetailsImage({required this.troop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 28.0, right: 28.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Hero(
                      tag: troop.name,
                      child: Image.asset(
                        troop.image,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TroopDetailsName extends StatelessWidget {
  final String name;

  const _TroopDetailsName({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      height: 86,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.1),
                  fontWeight: FontWeight.bold,
                  fontSize: 56,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
