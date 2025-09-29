import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmsn20252/models/planet_model.dart';

class PlanetDetailScreen extends StatefulWidget {
  const PlanetDetailScreen({super.key});

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  int selectedIndex = 0;

  final List<Planet> planets = [
    Planet(
      name: "Tatooine",
      backgroundImage: "assets/tatooine_bg.jpg",
      planetImage: "assets/tatooine.png",
      mass: "5.97",
      gravity: "9.8",
      day: "24",
      escapeVelocity: "11.2",
      temperature: "15",
      distance: "149.6",
    ),
    Planet(
      name: "Hoth",
      backgroundImage: "assets/hoth_bg.jpg",
      planetImage: "assets/hoth.png",
      mass: "0.642",
      gravity: "3.7",
      day: "24.6",
      escapeVelocity: "5.0",
      temperature: "-63",
      distance: "227.9",
    ),
    Planet(
      name: "Endor",
      backgroundImage: "assets/endor_bg.jpg",
      planetImage: "assets/endor.png",
      mass: "1898",
      gravity: "24.8",
      day: "9.9",
      escapeVelocity: "59.5",
      temperature: "-108",
      distance: "778.5",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPlanet = planets[selectedIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo completo con blur
          SizedBox.expand(
            child: Image.asset(
              currentPlanet.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

          // Botón regresar y favorito
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido principal en tarjeta traslúcida
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Imagen PNG del planeta
                  Image.asset(
                    currentPlanet.planetImage,
                    height: 100,
                  ),
                  const SizedBox(height: 12),

                  // Nombre del planeta
                  Text(
                    currentPlanet.name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Datos en Wrap
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildInfo(Icons.scale, "Mass\n(10^24kg)", currentPlanet.mass),
                      _buildInfo(Icons.architecture, "Gravity\n(m/s²)", currentPlanet.gravity),
                      _buildInfo(Icons.wb_sunny, "Day\n(hours)", currentPlanet.day),
                      _buildInfo(Icons.rocket_launch, "Esc. Velocity\n(km/s)", currentPlanet.escapeVelocity),
                      _buildInfo(Icons.thermostat, "Mean Temp\n(C)", currentPlanet.temperature),
                      _buildInfo(Icons.straighten, "Distance\n(10^6 km)", currentPlanet.distance),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Botón Visit
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${currentPlanet.name} visited!"),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Visit",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Flechas para cambiar planeta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          if (selectedIndex > 0) {
                            setState(() {
                              selectedIndex--;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onPressed: () {
                          if (selectedIndex < planets.length - 1) {
                            setState(() {
                              selectedIndex++;
                            });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(IconData icon, String label, String value) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
