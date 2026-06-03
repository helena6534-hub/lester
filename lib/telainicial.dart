import 'package:flutter/material.dart';
import 'package:lester/livro.dart'; // ← IMPORT ADICIONADO
import 'package:lester/perfil.dart';
import 'package:lester/telapesquisa.dart';

void main() {
  runApp(const Telainicial());
}

class Telainicial extends StatelessWidget {
  const Telainicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lêster',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Telainicial()),
      );
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Telapesquisa()),
      );
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Perfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      "imagens/habito.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Obras em destaque',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B8FA3),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildBookCard("imagens/crime.jpg"), // ← navegação adicionada dentro
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Screllers da semana',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B94B8),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _buildPodium(),

              const SizedBox(height: 40),

              _buildRankingList(),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBookCard(String imagePath) {
    return GestureDetector( // ← ADICIONADO
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Livro()),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.book, size: 50, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPodium() {
    return Column(
      children: [
        const Icon(Icons.star, color: Color(0xFF4A7C99), size: 125),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildPodiumBar(120, const Color(0xFF4A7C99)),
            const SizedBox(width: 8),
            _buildPodiumBar(180, const Color(0xFF4A7C99)),
            const SizedBox(width: 8),
            _buildPodiumBar(150, const Color(0xFF4A7C99)),
          ],
        ),
      ],
    );
  }

  Widget _buildPodiumBar(double height, Color color) {
    return Container(
      width: 80,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }

  Widget _buildRankingList() {
    final List<Map<String, dynamic>> users = [
      {
        'name': 'Eva Barreto',
        'lesters': '1290 Screllers',
        'color': const Color(0xFFE89A7D),
        'avatar': Icons.person,
      },
      {
        'name': 'Vinicius Pereira',
        'lesters': '1100 Screllers',
        'color': const Color(0xFF87CEEB),
        'avatar': Icons.person,
      },
      {
        'name': 'Pedro Lucas',
        'lesters': '928 Screllers',
        'color': const Color(0xFF6AA5C0),
        'avatar': Icons.person,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: users.map((user) => _buildRankingItem(user)).toList(),
      ),
    );
  }

  Widget _buildRankingItem(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3E7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4A7C99).withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: user['color'],
            child: Icon(user['avatar'], size: 35, color: Colors.white),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              user['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5B9AB8),
              ),
            ),
          ),

          Text(
            user['lesters'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5B9AB8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFC5DAE8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: const Color(0xFF4A7A8F),
        unselectedItemColor: const Color(0xFF5B8FA3),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: 'Busca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_3x3, size: 28),
            label: 'Grid',
          ),
        ],
      ),
    );
  }
}