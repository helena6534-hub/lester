import 'package:flutter/material.dart';

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
        useMaterial3: true,
      ),
      home: const UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5D9E0),
      body: Stack(
        children: [
          Column(
            children: [
              // Top Section - Blue Background
              Expanded(
                flex: 4,
                child: Container(
                  color: const Color(0xFFC5D9E0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Avatar
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9B7A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 8,
                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom Section - Cream Background
              Expanded(
                flex: 6,
                child: Container(
                  color: const Color(0xFFF5EFD8),
                ),
              ),
            ],
          ),
          // Content overlay
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
                        // Name and Role
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
                          'Escritor',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF5899B3),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Follow Button
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
                              elevation: 3,
                            ),
                            child: const Text(
                              'Seguir',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Followers Count
                        const Text(
                          '4587 Seguidores',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5899B3),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Three Cards Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildCard('Obras'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildCard('Screllers'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildCard('Lesters'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Reviews Section Button
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
                              elevation: 3,
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

                        // Review Card
                        Container(
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
                              // User Avatar
                              Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0B5F7D),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Review Content
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
                                      'Livro lindo!Superou o meu....',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          size: 18,
                                          color: Color(0xFF0B5F7D),
                                        ),
                                        const SizedBox(width: 6),
                                        const Text(
                                          '104 Curtidas',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF0B5F7D),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Book Cover
                              Container(
                                width: 60,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB8C945),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
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
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFC5D9E0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home,
                      size: 32,
                      color: Color(0xFF0B5F7D),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                      color: Color(0xFF0B5F7D),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                      size: 32,
                      color: Color(0xFF0B5F7D),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.grid_3x3,
                      size: 32,
                      color: Color(0xFF0B5F7D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF0B5F7D),
          ),
        ),
      ),
    );
  }
}

// Custom painter for avatar illustration
class AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F)
      ..style = PaintingStyle.fill;

    // Draw head (circle)
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.15,
      paint,
    );

    // Draw body (path)
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.25, size.height * 0.75);
    bodyPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.5,
    );
    bodyPath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.5,
      size.width * 0.75,
      size.height * 0.75,
    );
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
