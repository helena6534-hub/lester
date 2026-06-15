import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF5F3E7),
      ),
      home: const Obrascard2(),
    );
  }
}

class Obrascard2 extends StatefulWidget {
  final String initialFilter;

  const Obrascard2({super.key, this.initialFilter = 'Screllers'});

  @override
  State<Obrascard2> createState() => _Obrascard2State();
}

class _Obrascard2State extends State<Obrascard2> {
  late String _activeFilter;

  final List<String> _filters = ['Screllers', 'Lesters'];

  final List<Map<String, dynamic>> _mostSearchedReaders = [
    {
      'name': 'A Hora da Estrela',
      'image': 'https://m.media-amazon.com/images/I/61TaHURu27L.jpg',
      'likes': 2300,
    },
  ];

  final List<Map<String, dynamic>> _mostSearchedAuthors = [
    {
      'name': 'Capitães de Areia',
      'image': 'https://m.media-amazon.com/images/I/81iVW0VvbUL._UF1000,1000_QL80_.jpg',
      'likes': 2300,
    },
  ];

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> displayedItems = _activeFilter == 'Screllers'
        ? _mostSearchedReaders
        : _mostSearchedAuthors;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E7), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F3E7),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xFF4A7C99),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: _filters.map((filter) {
                        final isActive = _activeFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(filter),
                            selected: isActive,
                            onSelected: (_) =>
                                setState(() => _activeFilter = filter),
                            backgroundColor: const Color(0xFFD4E6EE),
                            selectedColor: const Color(0xFFA8C5D6),
                            labelStyle: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xFF7F97B8),
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

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width < 600 ? 3 : 6,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.55,
                          ),
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        final item = displayedItems[index];

                        return Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['name'],
                              style: const TextStyle(
                                color: Color(0xFF5B8FA3),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
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
                                  '${item['likes']}',
                                  style: const TextStyle(
                                    color: Color(0xFF5B8FA3),
                                    fontSize: 14,
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
    );
  }
}