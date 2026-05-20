import 'package:flutter/material.dart';
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
      title: 'User Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Perfil(),
    );
  }
}

class Perfil extends StatefulWidget {
  final int initialLikes;

  const Perfil({super.key, this.initialLikes = 104});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  late int _likes;
  bool _liked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _likes = widget.initialLikes;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      if (_liked) {
        _likes--;
        _liked = false;
      } else {
        _likes++;
        _liked = true;
      }
    });
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5D9E0),
      body: Stack(
        children: [
          // Fundo dividido em duas cores
          Column(
            children: [
              Expanded(flex: 4, child: Container(color: const Color(0xFFC5D9E0))),
              Expanded(flex: 6, child: Container(color: const Color(0xFFF5EFD8))),
            ],
          ),

          // Avatar centralizado no topo
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9B7A),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(100, 100),
                    painter: AvatarPainter(),
                  ),
                ),
              ),
            ),
          ),

          // Conteúdo principal
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5EFD8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      children: [
                        // Nome e profissão
                        const Text(
                          'Eva Barreto',
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF0B5F7D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Escritora',
                          style: TextStyle(fontSize: 20, color: Color(0xFF5899B3)),
                        ),
                        const SizedBox(height: 24),

                        // Botão Seguir
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B5F7D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Seguir', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Seguidores
                        const Text(
                          '4587 Seguidores',
                          style: TextStyle(fontSize: 16, color: Color(0xFF5899B3)),
                        ),
                        const SizedBox(height: 24),

                        // Cards de estatísticas
                        Row(
                          children: [
                            Expanded(child: _buildCard('Obras')),
                            const SizedBox(width: 12),
                            Expanded(child: _buildCard('Screllers')),
                            const SizedBox(width: 12),
                            Expanded(child: _buildCard('Lesters')),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Botão Resenhas
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B5F7D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Resenhas',
                                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Card de resenha
                        _buildResenhaCard(),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Card de resenha ──────────────────────────────────────────────
  Widget _buildResenhaCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar do usuário
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF0B5F7D),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),

          // Texto + curtida
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@Eva Barreto',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5899B3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Livro lindo! Superou o meu...',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                ),
                const SizedBox(height: 12),

                // Botão de curtir
                GestureDetector(
                  onTap: _toggleLike,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Icon(
                          _liked ? Icons.favorite : Icons.favorite_border,
                          color: _liked ? Colors.red : const Color(0xFF0B5F7D),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$_likes ${_likes == 1 ? 'Curtida' : 'Curtidas'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0B5F7D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Capa do livro
          Container(
            width: 60,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFB8C945),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'PESSOAS\nNORMAIS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Navigation Bar ────────────────────────────────────────
  Widget _buildBottomNav() {
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
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Telainicial()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Telapesquisa()),
            );
          }
          // index == 2 já é a tela atual
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
    );
  }

  // ── Card genérico ────────────────────────────────────────────────
  Widget _buildCard(String label) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFC5D9E0),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Color(0xFF0B5F7D)),
        ),
      ),
    );
  }
}

// ── Avatar customizado ───────────────────────────────────────────────
class AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F)
      ..style = PaintingStyle.fill;

    // Cabeça
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.15,
      paint,
    );

    // Corpo
    final bodyPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.75, size.height * 0.5,
        size.width * 0.75, size.height * 0.75,
      )
      ..close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}