import 'package:flutter/material.dart';
import 'package:lester/telapesquisa.dart';
import 'cadastro.dart';



class Telainicial extends StatelessWidget {
  const Telainicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lêster',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
}




class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3E7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner superior
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset("imagens/habito.png", fit: BoxFit.cover),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Obras em destaque
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Obras em destaque',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B94B8),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Grid de livros
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "imagens/crime.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Scrollers da semana
              

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 80,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 5,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFFB8D4E5),
          borderRadius: BorderRadius.circular(60),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.search, 1),
            _buildNavItem(Icons.person, 2),
            _buildNavItem(Icons.grid_view, 3),
          ],
        ),
      ),
    );
  }

 Widget _buildNavItem(IconData icon, int index) {

  final isSelected = _selectedIndex == index;

  return GestureDetector(

    onTap: () {

      setState(() {
        _selectedIndex = index;
      });

      // Navegação entre páginas
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Telainicial(),
          ),
        );
      }

      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Telapesquisa(),
          ),
        );
      }

      
    },

    child: Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: isSelected
            ? Color(0xFFA3CEE8)
            : Colors.transparent,
      ),

      child: Icon(
        icon,
        color: isSelected
            ? const Color(0xFF4A7C99)
            : const Color(0xFF7F97B8),
        size: 30,
      ),
    ),
  );
}

  Widget _buildBookCard(
    String title,
    String author,
    Color color, {
    IconData? icon,
    bool hasImage = false,
    bool isHarryPotter = false,
  }) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Conteúdo do livro
          if (icon != null)
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Icon(icon, size: 50, color: Colors.white.withOpacity(0.9)),
            ),

          if (hasImage)
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (isHarryPotter)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Harry\nPotter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Título e autor na parte inferior
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isHarryPotter)
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (!isHarryPotter) const SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 9,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
