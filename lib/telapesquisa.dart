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
      debugShowCheckedModeBanner: false,
      title: 'Tela de Pesquisa',
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

  final TextEditingController _searchController =
      TextEditingController();

  String _activeFilter = 'Livros';

  final List<String> _filters = [
    'Livros',
    'Leitores',
    'Autores'
  ];
  // LIVROS
  final List<Map<String, dynamic>> _mostSearchedBooks = [
    {
      'name': 'Crime e Castigo',
      'image':
          'https://m.media-amazon.com/images/I/916WkSH4cGL.jpg',
      'likes': 2785,
    },
  ];
  // LEITORES
  final List<Map<String, dynamic>> _mostSearchedReaders = [
    {
      'name': 'Ana Clara',
      'lesters': '2300 Seguidores',
      'color': const Color.fromARGB(255, 163, 91, 91),
      'avatar': Icons.person,  
    },
  ];
  // AUTORES
  final List<Map<String, dynamic>> _mostSearchedAuthors = [
    {
      'name': 'Eva Barreto',
      'lesters': '2300 Seguidores',
      'color': const Color(0xFF5B8FA3),
      'avatar': Icons.person,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ESCOLHE A LISTA
    List<Map<String, dynamic>> displayedItems;

    if (_activeFilter == 'Livros') {
      displayedItems = _mostSearchedBooks;
    } else if (_activeFilter == 'Leitores') {
      displayedItems = _mostSearchedReaders;
    } else {
      displayedItems = _mostSearchedAuthors;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // SEARCH BAR
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 205, 218, 226),
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration:
                            const InputDecoration(
                          hintText: 'Busca',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F97B8),
                            fontSize: 18,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                left: 24, right: 16),
                            child: Icon(
                              Icons.search,
                              color: Color(0xFF7F97B8),
                              size: 24,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF7F97B8),
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // FILTROS
                    Row(
                      children: _filters.map((filter) {
                        final isActive =
                            _activeFilter == filter;

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                                  right: 12),
                          child: FilterChip(
                            label: Text(filter),
                            selected: isActive,
                            onSelected: (selected) {
                              setState(() {
                                _activeFilter =
                                    filter;
                              });
                            },
                            backgroundColor:
                                const Color(
                                    0xFFD4E6EE),
                            selectedColor:
                                const Color(
                                    0xFFA8C5D6),
                            labelStyle: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(
                                      0xFF7F97B8),
                              fontWeight:
                                  FontWeight.w500,
                            ),
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(20),
                              side:
                                  BorderSide.none,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    // TITULO
                    const Text(
                      'Mais buscados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B8FA3),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // GRID
                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context)
                                        .size
                                        .width <
                                    600
                                ? 1
                                : 6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.55,
                      ),
                      itemCount:
                          displayedItems.length,
                      itemBuilder:
                          (context, index) {
                        final item =
                            displayedItems[index];
                        // LIVROS
                        if (_activeFilter ==
                            'Livros') {
                          return Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              20),
                                  child:
                                      Image.network(
                                    item['image'],
                                    fit:
                                        BoxFit
                                            .cover,
                                    width: double
                                        .infinity,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(
                                item['name'],
                                style:
                                    const TextStyle(
                                  color: Color(
                                      0xFF5B8FA3),
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  fontSize: 14,
                                ),
                                textAlign:
                                    TextAlign
                                        .center,
                              ),

                              const SizedBox(
                                  height: 4),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(
                                        0xFF5B8FA3),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                      width: 4),
                                  Text(
                                    '${item['likes']}',
                                    style:
                                        const TextStyle(
                                      color: Color(
                                          0xFF5B8FA3),
                                      fontSize:
                                          14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        // LEITORES E AUTORES
                        return SizedBox(
                          width: 300,
                          height: 120,
                          child:  Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F3E7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFF4A7C99).withOpacity(0.1), width: 2),
                          ),
                          )
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: item['color'],
                                child: Icon(item['avatar'], size: 35, color: Colors.white),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF5B9AB8),
                                  ),
                                ),
                              ),

                              Text(
                                item['lesters'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5B9AB8),
                                ),
                              ),
                            ],
                          ),
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
      // BOTÃO DE NAVEGAÇÃO
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
                MaterialPageRoute(
                  builder: (context) =>
                      Telainicial(),
                ),
              );
            }

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Telapesquisa(),
                ),
              );
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          selectedItemColor:
              const Color(0xFF4A7A8F),
          unselectedItemColor:
              const Color(0xFF5B8FA3),
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