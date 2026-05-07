import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lêster Tela inicial',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Telainicial(),
    );
  }
}

class Telainicial extends StatelessWidget {
  const Telainicial({super.key});

  static const Color beigeBackground = Color(0xFFFFFAEB);
  static const Color blueAccent = Color(0xFF5B9AB8);
  static const Color blueButton = Color(0xFF6AAFCC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beigeBackground,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Hero com imagem de biblioteca
                  _buildHeroBanner(),

                  const SizedBox(height: 24),

                  // Obras em destaque
                  _buildFeaturedBooks(),

                  const SizedBox(height: 32),

                  // Screllers da semana
                  _buildScrollersSection(),

                  const SizedBox(height: 100), // Espaço para bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texto principal
              const Text(
                'Descubra obras que iluminam o pensamento e a alma',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Botão Catálogo
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para catálogo
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueButton,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Catalogo',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBooks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Obras em destaque',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: blueAccent,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Lista horizontal de livros
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildBookCard(
                'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400&q=80',
                '1984',
              ),
              _buildBookCard(
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&q=80',
                'Crime e Castigo',
              ),
              _buildBookCard(
                'https://images.unsplash.com/photo-1621351183012-e2f9972dd9bf?w=400&q=80',
                'Harry Potter',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookCard(String imageUrl, String title) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Capa do livro
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollersSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Screllers da semana',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: blueAccent,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 20),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFB8D8E5),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavIcon(Icons.home, true),
          _buildNavIcon(Icons.search, false),
          _buildNavIcon(Icons.person, false),
          _buildNavIcon(Icons.grid_view_rounded, false),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(
        icon,
        size: 32,
        color: isActive
            ? const Color(0xFF4A7B99)
            : const Color(0xFF4A7B99).withOpacity(0.5),
      ),
    );
  }
}
