import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Favoritos",
          style: GoogleFonts.orbitron(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "Que la Fuerza te acompañe ✨",
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Estos son tus héroes, villanos y naves favoritas",
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Facciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Facciones",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Ver todas",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(color: Colors.yellow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    factionItem("Imperio", "assets/imperio_faction.png"),
                    factionItem("Rebeldes", "assets/rebels_faction.png"),
                    factionItem("Mandalorianos", "assets/mandalorian_faction.png"),
                    factionItem("Jedi", "assets/jedis_faction.png"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Naves Favoritas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tus naves favoritas",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Ver todas",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(color: Colors.yellow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              starshipCard(
                "Millennium Falcon",
                "La nave más rápida de la galaxia",
                "assets/falcon.png",
                rating: 5.0,
              ),
              const SizedBox(height: 20),
              starshipCard(
                "TIE Fighter",
                "Caza estelar del Imperio",
                "assets/tiefighter.png",
                rating: 4.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget de facciones con assets
  static Widget factionItem(String name, String imgAsset) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            radius: 28,
            backgroundImage: AssetImage(imgAsset),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.orbitron(
              textStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Widget de naves flotando sobre la tarjeta
  static Widget starshipCard(String title, String subtitle, String imgAsset,
      {double rating = 5.0}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.orbitron(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: GoogleFonts.orbitron(
                          textStyle: const TextStyle(
                              color: Colors.grey, fontSize: 12),
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 18),
                  const SizedBox(width: 4),
                  Text(rating.toString(),
                      style: GoogleFonts.orbitron(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ],
              )
            ],
          ),
        ),
        // Imagen de la nave flotando
        Positioned(
          top: 0,
          left: 20,
          right: 20,
          child: SizedBox(
            height: 120,
            child: Image.asset(imgAsset, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
