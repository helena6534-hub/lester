import 'package:flutter/material.dart';
import 'package:lester/perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mudar para Escritor/leitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F3E7),
      ),
      home: const Escritorleitor(),
    );
  }
}

class Escritorleitor extends StatefulWidget {
  const Escritorleitor({super.key});

  @override
  State<Escritorleitor> createState() => _EscritorleitorState();
}

class _EscritorleitorState extends State<Escritorleitor> {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _gmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Mudar para Escritor/leitor',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: bluePetrol,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // CAMPO USUÁRIO
                    Container(
                      decoration: BoxDecoration(
                        color: bgBeige,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: blueLight, width: 1.5),
                      ),
                      child: TextField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          labelStyle: TextStyle(color: textBlue, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(fontSize: 16, color: textBlue),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // CAMPO GMAIL
                    Container(
                      decoration: BoxDecoration(
                        color: bgBeige,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: blueLight, width: 1.5),
                      ),
                      child: TextField(
                        controller: _gmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: textBlue, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(fontSize: 16, color: textBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTÃO CONCLUIR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Perfil()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluePetrol,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
