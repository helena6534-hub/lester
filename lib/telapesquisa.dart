import 'package:flutter/material.dart';
import 'package:lester/telainicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Pesquisa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFFFAEB),
      ),
      home: const Telapesquisa(),
    );
  }
}

class Telapesquisa extends StatefulWidget {
  const Telapesquisa({super.key});

  @override
  State<Telapesquisa> createState() => _TelapesquisaState();
}

class _TelapesquisaState extends State<Telapesquisa> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final TextEditingController _searchController = TextEditingController();
  String _activeFilter = 'Livros';

  final List<String> _filters = ['Livros', 'Leitores', 'Autores'];

  final List<Map<String, dynamic>> _mostSearchedBooks = [
    {
      'id': 1,
      'title': 'Crime e Castigo',
      'author': 'Fiodor Dostoievski',
      'cover': 'https://m.media-amazon.com/images/I/916WkSH4cGL.jpg',
      'likes': 2785,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 205, 218, 226),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Busca',
                          hintStyle: const TextStyle(
                            color: Color(0xFF7F97B8),
                            fontSize: 18,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 24, right: 16),
                            child: Icon(
                              Icons.search,
                              color: Color(0xFF7F97B8),
                              size: 24,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF5B8FA3),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Filter Chips
                    Row(
                      children: _filters.map((filter) {
                        final isActive = _activeFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(filter),
                            selected: isActive,
                            onSelected: (selected) {
                              setState(() {
                                _activeFilter = filter;
                              });
                            },
                            backgroundColor: const Color(0xFFD4E6EE),
                            selectedColor: const Color(0xFFA8C5D6),
                            labelStyle: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xFF5B8FA3),
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide.none,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    // Most Searched Section
                    const Text(
                      'Mais buscados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B8FA3),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Books Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width < 600
                            ? 3
                            : 6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.55,
                      ),
                      itemCount: _mostSearchedBooks.length,
                      itemBuilder: (context, index) {
                        final book = _mostSearchedBooks[index];
                        return Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  book['cover'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Color(0xFF5B8FA3),
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${book['likes']}',
                                  style: const TextStyle(
                                    color: Color(0xFF5B8FA3),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
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
                MaterialPageRoute(builder: (context) => Telainicial()),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Telapesquisa()),
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
}
