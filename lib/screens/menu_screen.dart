import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class StarWarsMenuScreen extends StatefulWidget {
  final VoidCallback? onSelectHeroes;
  
  StarWarsMenuScreen({Key? key, this.onSelectHeroes}) : super(key: key);


  @override
  State<StarWarsMenuScreen> createState() => _StarWarsMenuScreenState();
}

class _StarWarsMenuScreenState extends State<StarWarsMenuScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8, initialPage: 1000);
  int _currentPage = 1000;
  late Timer _timer;

  String _selectedFilter = "Todos";
  String _searchQuery = "";

  final List<Map<String, dynamic>> _sections = [
    {"title": "Héroes", "image": "assets/jedis.jpg", "color": Colors.yellow, "category": "Personajes"},
    {"title": "Tropas", "image": "assets/troops.jpg", "color": Colors.orange, "category": "Personajes"},
    {"title": "Sables láser", "image": "assets/lightsaber.jpg", "color": Colors.red, "category": "Armas"},
    {"title": "Pistolas", "image": "assets/blasters.jpg", "color": Colors.pink, "category": "Armas"},
    {"title": "Aeronaves", "image": "assets/ships.jpg", "color": Colors.blue, "category": "Vehículos"},
    {"title": "Vehículos terrestres", "image": "assets/vehicles.jpg", "color": Colors.green, "category": "Vehículos"},
    {"title": "Planetas", "image": "assets/planets.jpg", "color": const Color.fromARGB(255, 175, 76, 130), "category": "Otros"},
  ];

  final List<String> _filters = ["Todos", "Personajes", "Armas", "Vehículos"];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final filteredSections = _sections.where((s) {
      final matchesFilter = _selectedFilter == "Todos" || s["category"] == _selectedFilter;
      final matchesSearch = s["title"].toString().toLowerCase().contains(_searchQuery);
      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Forma tu equipo intergaláctico",
          style: GoogleFonts.orbitron(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Filtros
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  final color = isSelected ? Colors.orange : Colors.grey;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.withOpacity(0.15),
                        foregroundColor: color,
                        shape: const StadiumBorder(),
                        side: BorderSide(color: color, width: 2),
                      ),
                      child: Text(filter, style: TextStyle(color: color)),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Barra de búsqueda
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: "Buscar en el menú galáctico...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),

            const SizedBox(height: 20),

            // Título principal arriba del carrusel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Elige tu categoría galáctica",
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Carrusel infinito
            Expanded(
              child: filteredSections.isEmpty
                  ? Center(
                      child: Text(
                        "No se encontraron resultados",
                        style: GoogleFonts.orbitron(
                          textStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: null, // infinito
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final section = filteredSections[index % filteredSections.length];

                        double scale = 1.0;
                        if (_pageController.hasClients && _pageController.page != null) {
                          scale = (_pageController.page! - index).abs();
                          scale = (1 - (scale * 0.3)).clamp(0.7, 1.0);
                        }

                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.7, end: scale),
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: child,
                            );
                          },
                          child: _menuCard(
                            title: section["title"],
                            imageUrl: section["image"],
                            color: section["color"],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({required String title, required String imageUrl, required Color color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: SizedBox.expand(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: GoogleFonts.orbitron(
                textStyle: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed: () {
                if (title == "Aeronaves") {
                  Navigator.pushNamed(context, "/starship");
                } else if (title == "Planetas") {
                  Navigator.pushNamed(context, "/planet");
                } else if (title == "Héroes") {
                  if (widget.onSelectHeroes != null) widget.onSelectHeroes!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Explorando $title...")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              child: const Text("Explorar"),
            ),
          ),
        ],
      ),
    );
  }
}
