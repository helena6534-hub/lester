import 'package:flutter/material.dart';
import 'package:lester/modelos/livros.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Telapesquisa(),
    );
  }
}


class Telapesquisa extends StatefulWidget {
  const Telapesquisa({Key? key}) : super(key: key);

  @override
  State<Telapesquisa> createState() => _TelapesquisaState();
}

class _TelapesquisaState extends State<Telapesquisa> {
  String searchQuery = '';
  final List<Livros> allBooks = Livros.getSampleBooks();

  List<Livros> get filteredBooks {
    if (searchQuery.isEmpty) return allBooks;

    return allBooks.where((book) {
      return book.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            searchQuery.isNotEmpty
                ? 'Resultados para "$searchQuery"'
                : 'Todos os livros',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4a7c8a),
            ),
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
