import 'package:flutter/material.dart';
import 'package:lester/livro.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  bool _seguindo = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  // Mesmas cores da tela inicial
  static const Color blueMedium  = Color(0xFF7F97B8);
  static const Color bluePetrol  = Color(0xFF4A7C99);
  static const Color beigeLight  = Color(0xFFF5F3E7);
  static const Color blueLight   = Color(0xFFA3CEE8);
  static const Color textBlue    = Color(0xFF5B8FA3);

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
        MaterialPageRoute(builder: (context) => const Telapesquisa()),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Perfil()),
      );
    }
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
      backgroundColor: const Color(0xFFF5F3E7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header com botão de voltar ──────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: bluePetrol,
                  ),
                ),
              ),

              // ── Avatar centralizado ─────────────────────────────
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE89A7D),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: bluePetrol,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: const Size(90, 90),
                      painter: AvatarPainter(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Nome e profissão ────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Eva Barreto',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: textBlue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Escritora',
                            style: TextStyle(
                              fontSize: 20,
                              color: textBlue,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Seguidores como tag (estilo da tela inicial — pill suave)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F3E7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: bluePetrol.withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              '4587 Seguidores',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Ícone de seguir
                    InkWell(
                      onTap: () => setState(() => _seguindo = !_seguindo),
                      child: Icon(
                        _seguindo
                            ? Icons.person
                            : Icons.person_add_outlined,
                        size: 40,
                        color: _seguindo
                            ? bluePetrol
                            : bluePetrol.withOpacity(0.35),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Cards de estatísticas (mesmo estilo do ranking da tela inicial) ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: _buildStatsCard('Obras', '32')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatsCard('Screllers', '1.2k')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatsCard('Lesters', '3.4k')),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Botão Resenhas ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // canto esquerdo
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: bluePetrol,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Resenhas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Card de resenha (mesmo estilo dos itens de ranking) ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildResenhaCard(),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ── Card de resenha ──────────────────────────────────────────────
  Widget _buildResenhaCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3E7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: bluePetrol.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar (mesmo estilo do CircleAvatar do ranking)
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFE89A7D),
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@Eva Barreto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B9AB8),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Livro lindo! Superou o meu...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5B9AB8),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _toggleLike,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Icon(
                          _liked ? Icons.favorite : Icons.favorite_border,
                          color: _liked
                              ? bluePetrol
                              : bluePetrol.withOpacity(0.4),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$_likes ${_likes == 1 ? 'Curtida' : 'Curtidas'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _liked
                              ? bluePetrol
                              : const Color(0xFF5B9AB8),
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

  // ── Card de estatística ─────────────────────────────────────────
  Widget _buildStatsCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFA3CEE8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF5B9AB8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5B9AB8),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Navigation Bar (idêntica à tela inicial) ─────────────
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

// ── Avatar customizado (mantido) ─────────────────────────────────────
class AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.15,
      paint,
    );

    final bodyPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.5,
        size.width * 0.75,
        size.height * 0.75,
      )
      ..close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}