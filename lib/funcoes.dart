import 'package:flutter/material.dart';
import 'package:lester/perfil.dart';
import 'package:lester/telainicial.dart';
import 'package:lester/telapesquisa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Principal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5E6D3),
      ),
      home: const Funcoes(),
    );
  }
}

class Funcoes extends StatefulWidget {
  const Funcoes({super.key});

  @override
  State<Funcoes> createState() => _FuncoesState();
}

class _FuncoesState extends State<Funcoes> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            childAspectRatio: 1.3,
            children: [
              _buildMenuCard(
                icon: Icons.assignment_turned_in_outlined,
                label: 'Planos',
                onTap: () {
                  // Navegar para tela de Planos
                },
              ),
              _buildMenuCard(
                icon: Icons.menu,
                label: 'Configurações',
                onTap: () {
                  // Navegar para tela de Configurações
                },
              ),
              _buildMenuCard(
                icon: Icons.edit,
                label: 'Publique',
                onTap: () {
                  // Navegar para tela de Publicação
                },
              ),
              _buildMenuCard(
                icon: Icons.mic_none,
                label: 'Dicas com IA',
                onTap: () {
                  // Navegar para tela de Dicas com IA
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC5DAE8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Telainicial()),
              );
            }

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Telapesquisa()),
              );
            }

            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Perfil()),
              );
            }
          },
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
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD4E6F1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: const Color(0xFF5B8DB8),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5B8DB8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}