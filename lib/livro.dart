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
      title: 'Book Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const BookDetailsScreen(),
    );
  }
}

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
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
            // Header with back button
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
                  // Two-tone background
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

                  // Main content
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
                              child: Container(
                                color: const Color(0xFFB8C945),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '"O Estranho batiza lá dezida." — The Guardian',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const Column(
                                      children: [
                                        Text(
                                          'PESSOAS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          'NORMAIS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 60,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.album,
                                        size: 30,
                                        color: Color(0xFF1E3A5F),
                                      ),
                                    ),
                                    const Column(
                                      children: [
                                        Text(
                                          'SALLY',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          'ROONEY',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Content Section
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title, Author and Icons Row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        // Tags
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
                                  // Action Icons
                                  Column(
                                    children: [
                                      // Heart Icon
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
                                          size: 48,
                                          color: isFavorited
                                              ? const Color(0xFF0B5F7D)
                                              : const Color(
                                                  0xFF5899B3,
                                                ).withOpacity(0.4),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      // Bookmark Icon
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
                                          size: 48,
                                          color: isBookmarked
                                              ? const Color(0xFF0B5F7D)
                                              : const Color(
                                                  0xFF5899B3,
                                                ).withOpacity(0.4),
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
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildStatsCard('Screllers', '5412'),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Action Buttons
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0B5F7D),
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
                                    'Ler sinopse',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
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

                              // Review Card
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // User Avatar
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
                                    // Review Content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            'Livro lindo!Superou o meu....',
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
                                                  isReviewLiked
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  size: 20,
                                                  color: isReviewLiked
                                                      ? const Color(0xFF0B5F7D)
                                                      : const Color(
                                                          0xFF5899B3,
                                                        ).withOpacity(0.4),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  '$reviewLikes Curtidas',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: isReviewLiked
                                                        ? const Color(
                                                            0xFF0B5F7D,
                                                          )
                                                        : const Color(
                                                            0xFF5899B3,
                                                          ).withOpacity(0.6),
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

  Widget _buildStatsCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Color(0xFF5899B3)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF5899B3),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
