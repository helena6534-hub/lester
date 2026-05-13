import 'package:flutter/material.dart';


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
  


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
         
          const SizedBox(height: 16),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
