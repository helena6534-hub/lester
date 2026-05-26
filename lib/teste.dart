import 'package:flutter/material.dart';
import 'tela_lesters.dart';
import 'tela_screllers.dart';

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
      theme: ThemeData(useMaterial3: true),
      home: const livro(),
    );
  }
}

class livro extends StatefulWidget {
  const livro({super.key});

  @override
  State<livro> createState() => _livroState();
}

class _livroState extends State<livro> {
  bool isFavorited = false;
  bool isBookmarked = false;
  bool isReviewLiked = false;
  int reviewLikes = 104;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5D9E0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Color(0xFF0B5F7D),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(color: const Color(0xFFC5D9E0)),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(color: const Color(0xFFF5EFD8)),
                      ),
                    ],
                  ),

                  SingleChildScrollView(
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
                                'assets/capa_livro.jpg',
                                width: 180,
                                height: 270,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pessoas normais',
                                          style: TextStyle(
                                            fontSize: 26,
                                            color: Color(0xFF5899B3),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Sally Rooney',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF5899B3),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            _buildTag('Romance'),
                                            const SizedBox(width: 12),
                                            _buildTag('Completa'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isFavorited = !isFavorited;
                                          });
                                        },
                                        child: Icon(
                                          isFavorited ? Icons.favorite : Icons.favorite_border,
                                          size: 48,
                                          color: isFavorited
                                              ? const Color(0xFF0B5F7D)
                                              : const Color(0xFF5899B3).withOpacity(0.4),
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
                                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                          size: 48,
                                          color: isBookmarked
                                              ? const Color(0xFF0B5F7D)
                                              : const Color(0xFF5899B3).withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Stats Cards — agora são botões
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatsCard(
                                      context,
                                      'Lesters',
                                      '12400',
                                      const TelaLesters(),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildStatsCard(
                                      context,
                                      'Screllers',
                                      '5412',
                                      const TelaScrellers(),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

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
                                    'Ler sinopse',
                                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

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
                                    'Escrever Resenha',
                                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF9B7A),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF0B5F7D),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Color(0xFF1E3A5F),
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '@Eva Barreto',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF5899B3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Livro lindo! Superou o meu....',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF5899B3),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          InkWell(
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
                                              children: [
                                                Icon(
                                                  isReviewLiked ? Icons.favorite : Icons.favorite_border,
                                                  size: 20,
                                                  color: isReviewLiked
                                                      ? const Color(0xFF0B5F7D)
                                                      : const Color(0xFF5899B3).withOpacity(0.4),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  '$reviewLikes Curtidas',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: isReviewLiked
                                                        ? const Color(0xFF0B5F7D)
                                                        : const Color(0xFF5899B3).withOpacity(0.6),
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

                              const SizedBox(height: 40),
                            ],
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
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFC5D9E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Color(0xFF5899B3)),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, String label, String value, Widget destino) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destino),
        );
      },
      child: Container(
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
      ),
    );
  }
}