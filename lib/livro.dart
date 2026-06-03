import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Livro(),
    );
  }
}

class Livro extends StatefulWidget {
  const Livro({super.key});

  @override
  State<Livro> createState() => _LivroState();
}

class _LivroState extends State<Livro> {
  bool isFavorited = false;
  bool isBookmarked = false;
  bool isReviewLiked = false;
  int reviewLikes = 104;

  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color navBar = Color(0xFFC5DAE8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3E7),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: bluePetrol,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Book Cover
                    Center(
                      child: Container(
                        width: 180,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'imagens/crime.jpg',
                            width: 180,
                            height: 270,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Content Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title, Author and Icons Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Crime e Castigo',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: textBlue,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Fíodor Dostoiévski',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: textBlue,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Tags
                                    Row(
                                      children: [
                                        _buildTag('Suspense'),
                                        const SizedBox(width: 12),
                                        _buildTag('Completa'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Action Icons
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFavorited = !isFavorited;
                                      });
                                    },
                                    child: Icon(
                                      isFavorited
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 40,
                                      color: isFavorited
                                          ? bluePetrol
                                          : bluePetrol.withOpacity(0.35),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBookmarked = !isBookmarked;
                                      });
                                    },
                                    child: Icon(
                                      isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      size: 40,
                                      color: isBookmarked
                                          ? bluePetrol
                                          : bluePetrol.withOpacity(0.35),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Stats Cards
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatsCard('Lesters', '12400'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatsCard('Screllers', '5412'),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Escrever Resenha Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bluePetrol,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                              child: const Text(
                                'Escrever Resenha',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Resenhas label — igual ao Perfil
                          Align(
                            alignment: Alignment.centerLeft,
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

                          const SizedBox(height: 20),

                          // Review Card — igual ao _buildResenhaCard do Perfil
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: bgBeige,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: bluePetrol.withOpacity(0.1),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        onTap: () {
                                          setState(() {
                                            if (isReviewLiked) {
                                              reviewLikes--;
                                              isReviewLiked = false;
                                            } else {
                                              reviewLikes++;
                                              isReviewLiked = true;
                                            }
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              isReviewLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isReviewLiked
                                                  ? bluePetrol
                                                  : bluePetrol.withOpacity(0.4),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              '$reviewLikes Curtidas',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: isReviewLiked
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
                              ],
                            ),
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFA3CEE8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: textBlue),
      ),
    );
  }

  Widget _buildStatsCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFA3CEE8),
        borderRadius: BorderRadius.circular(16),
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
            style: const TextStyle(fontSize: 15, color: textBlue, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textBlue,
            ),
          ),
        ],
      ),
    );
  }
}