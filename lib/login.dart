import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
         

class login extends StatefulWidget {

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Paleta de cores
  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);
         
  // Guarda informações do usuario, evita vazamentos
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // Valida informações do usuario 
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Implementar lógica de login
      debugPrint('Login: ${_emailController.text}');
      debugPrint('Password: ${_passwordController.text}');
    }
  }
  // Implementar lógica de recuperação de senha
  void _handleForgotPassword() {
    debugPrint('Esqueceu a senha');
  }
  // Implementar lógica de cadastro
  void _handleSignUp() {
    debugPrint('Cadastrar nova conta');
  }
  //design das caixas de texto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              beigeLight,
              blueLight,
              blueMedium,
              bluePetrol,
            ],
            stops: [0.0, 0.35, 0.70, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo/Header
                      _buildHeader(),
                      const SizedBox(height: 32),

                      // Form Card
                      _buildFormCard(),
                      const SizedBox(height: 24),

                      // Footer - Cadastro
                      _buildFooter(),
                      const SizedBox(height: 32),

                      // Decorative Books
                      _buildDecorativeBooks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 //Informações acima das caixas de texto(logo, titulo)
  Widget _buildHeader() {
    return Column(
      children: [
        // Ícone circular
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: bluePetrol,
            shape: BoxShape.circle,
          ),
          child: Image.asset (
            'assets/username'
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: blueLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header do card
            Row(
              children: [
                const Icon(
                  Icons.book_outlined,
                  color: bluePetrol,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: bluePetrol,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Campo Email
            _buildLabel('Email'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hintText: 'seu@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu email';
                }
                if (!value.contains('@')) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Campo Senha
            _buildLabel('Senha'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _passwordController,
              hintText: '••••••••',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                if (value.length < 6) {
                  return 'Senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Link Esqueceu a senha
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _handleForgotPassword,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    fontSize: 14,
                    color: blueMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botão Login
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: bluePetrol,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: bluePetrol,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: beigeLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: blueLight, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: blueLight, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: bluePetrol, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Não tem uma conta? ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        TextButton(
          onPressed: _handleSignUp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Cadastre-se',
            style: TextStyle(
              fontSize: 14,
              color: beigeLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeBooks() {
    return Opacity(
      opacity: 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBookBar(blueLight, 48),
          const SizedBox(width: 8),
          _buildBookBar(blueMedium, 56),
          const SizedBox(width: 8),
          _buildBookBar(bluePetrol, 40),
          const SizedBox(width: 8),
          _buildBookBar(blueLight, 48),
          const SizedBox(width: 8),
          _buildBookBar(blueMedium, 64),
          const SizedBox(width: 8),
          _buildBookBar(bluePetrol, 44),
        ],
      ),
    );
  }

  Widget _buildBookBar(Color color, double height) {
    return Container(
      width: 8,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
