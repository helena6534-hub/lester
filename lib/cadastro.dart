import 'package:flutter/material.dart';
import 'package:lester/login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lêster Cadastro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  bool isLeitor = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  bool obscureSenha = true;
  bool obscureConfirmarSenha = true;

  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [beigeLight, Color(0xFF5B94B8), bluePetrol],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo e título
                  Image.asset("imagens/username.png", width: 500),

                  // Card branco com formulário
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.signpost_outlined,
                              color: bluePetrol,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Cadastre-se',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: bluePetrol,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        // Toggle Leitor/Escritor
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isLeitor = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLeitor
                                        ? const Color(0xFF4A91B8)
                                        : const Color(0xFFB8D4E5),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Leitor',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isLeitor = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !isLeitor
                                        ? const Color(0xFF4A91B8)
                                        : const Color(0xFFB8D4E5),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Escritor',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Campo Email
                        _buildTextField(
                          controller: emailController,
                          hint: 'Email',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 16),

                        // Campo Nome de Usuario
                        _buildTextField(
                          controller: nomeController,
                          hint: 'Nome de Usuario',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),

                        // Campo Senha
                        _buildTextField(
                          controller: senhaController,
                          hint: 'Senha',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: obscureSenha,
                          onToggleVisibility: () =>
                              setState(() => obscureSenha = !obscureSenha),
                        ),
                        const SizedBox(height: 16),

                        // Campo Confirmar senha
                        _buildTextField(
                          controller: confirmarSenhaController,
                          hint: 'Confirmar senha',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: obscureConfirmarSenha,
                          onToggleVisibility: () => setState(
                            () =>
                                obscureConfirmarSenha = !obscureConfirmarSenha,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Link "Já é cadastrado?"
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login()),
                            );
                            // Navegar para tela de login
                          },
                          child: const Text(
                            'Já é cadastrado?',
                            style: TextStyle(
                              color: Color(0xFF5B94B8),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Botão Cadastrar
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Lógica de cadastro
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B94B8),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5B94B8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(icon, color: Colors.white60, size: 22),
          ),
          suffixIcon: isPassword
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.lock_outline
                          : Icons.lock_open_outlined,
                      color: Colors.white60,
                      size: 22,
                    ),
                    onPressed: onToggleVisibility,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nomeController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }
}
