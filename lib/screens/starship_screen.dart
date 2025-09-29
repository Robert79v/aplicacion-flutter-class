import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmsn20252/models/starship_model.dart';

class StarshipScreen extends StatefulWidget {
  const StarshipScreen({super.key});

  @override
  State<StarshipScreen> createState() => _StarshipScreenState();
}

class _StarshipScreenState extends State<StarshipScreen> {
  int selectedIndex = 0;
  int selectedThumbnailIndex = 0;
  int quantity = 1;

  final List<Starship> starships = [
    Starship(
      name: "Millennium Falcon",
      model: "YT-1300f light freighter",
      manufacturer: "Corellian Engineering Corporation",
      speed: "1050 km/h (atmosfera)",
      crew: "4",
      mainImage: "assets/falcon.jpg",
      thumbnails: [
        "assets/falcon.jpg",
        "assets/falcon2.jpg",
        "assets/falcon3.jpg",
      ],
    ),
    Starship(
      name: "X-Wing",
      model: "T-65B starfighter",
      manufacturer: "Incom Corporation",
      speed: "1050 km/h (atmosfera)",
      crew: "1",
      mainImage: "assets/xwing.jpg",
      thumbnails: [
        "assets/xwing.jpg",
        "assets/xwing2.jpg",
        "assets/xwing3.jpg",
      ],
    ),
    Starship(
      name: "TIE Fighter",
      model: "Twin Ion Engine/Ln Starfighter",
      manufacturer: "Sienar Fleet Systems",
      speed: "1200 km/h (atmosfera)",
      crew: "1",
      mainImage: "assets/tiefighter.jpg",
      thumbnails: [
        "assets/tiefighter.jpg",
        "assets/tiefighter2.jpg",
        "assets/tiefighter3.jpg",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentShip = starships[selectedIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Star Wars Starships",
          style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.yellow],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  currentShip.thumbnails[selectedThumbnailIndex],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Galería de imágenes pequeñas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  currentShip.thumbnails.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedThumbnailIndex = index;
                      });
                    },
                    child: _miniImage(
                      currentShip.thumbnails[index],
                      isSelected: index == selectedThumbnailIndex,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Información de la nave
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentShip.name,
                    style: GoogleFonts.orbitron(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _infoRow("Modelo:", currentShip.model),
                  _infoRow("Fabricante:", currentShip.manufacturer),
                  _infoRow("Velocidad:", currentShip.speed),
                  _infoRow("Tripulación:", currentShip.crew),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Botones: cantidad y equipar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC93C),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                        ),
                        Text(
                          "$quantity",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 170, 30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Mostrar snack
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${currentShip.name} equipado x$quantity",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        // Redirigir al menú después del SnackBar
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Equipar",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Selector de naves con scroll horizontal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    starships.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == index
                              ? Colors.yellow
                              : Colors.grey[800],
                          foregroundColor: selectedIndex == index
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                            selectedThumbnailIndex = 0;
                          });
                        },
                        child: Text(starships[index].name),
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

  Widget _miniImage(String url, {bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.yellow, width: 2) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          url,
          height: 70,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
