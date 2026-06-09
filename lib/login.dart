import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lester/cadastro.dart';
import 'package:lester/telainicial.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const login(),
    );
  }
}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _senhaVisivel = false;
  bool _carregando = false;

  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color blueMedium = Color(0xFF7F97B8);
  static const Color bluePetrol = Color(0xFF4A7C99);

  // Regex de email — valida estrutura completa: nome@dominio.extensao
  // O nome (parte antes do @) não pode ter letras maiúsculas
  static final RegExp _emailRegex = RegExp(
    r'^[a-z0-9][a-z0-9\.\-\_]*@[a-z0-9][a-z0-9\.\-]*\.[a-z]{2,}$',
  );

  static final RegExp _temLetra    = RegExp(r'[a-zA-Z]');
  static final RegExp _temNumero   = RegExp(r'[0-9]');
  static final RegExp _temEspecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }

    final partes = value.trim().split('@');

    // Verifica se há exatamente uma parte antes e uma depois do @
    if (partes.length != 2) {
      return 'Insira um email válido (ex: nome@dominio.com)';
    }

    final nomeUsuario = partes[0];

    // Bloqueia maiúsculas especificamente no nome do usuário
    if (nomeUsuario != nomeUsuario.toLowerCase()) {
      return 'O nome do usuário não pode conter letras maiúsculas';
    }

    // Valida a estrutura completa do email
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Insira um email válido (ex: nome@dominio.com)';
    }

    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    if (!_temLetra.hasMatch(value)) {
      return 'A senha deve conter ao menos uma letra';
    }
    if (!_temNumero.hasMatch(value)) {
      return 'A senha deve conter ao menos um número';
    }
    if (!_temEspecial.hasMatch(value)) {
      return 'A senha deve conter ao menos um caractere especial (!@#...)';
    }
    return null;
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    setState(() => _carregando = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Telainicial()),
    );
  }

  void _handleSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cadastro()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [beigeLight, blueLight, blueMedium, bluePetrol],
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
                      _buildHeader(),
                      const SizedBox(height: 32),
                      _buildFormCard(),
                      const SizedBox(height: 24),
                      _buildFooter(),
                      const SizedBox(height: 32),
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

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset("imagens/username.png", width: 500),
        const SizedBox(width: 10),
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
            const Row(
              children: [
                Icon(Icons.book_outlined, color: bluePetrol, size: 20),
                SizedBox(width: 8),
                Text(
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

            _buildLabel('Email'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              // Converte automaticamente maiúsculas para minúsculas
              // apenas na parte antes do @ enquanto o usuário digita
              inputFormatters: [_LowercaseBeforeAtFormatter()],
              validator: _validarEmail,
              decoration: _inputDecoration('seu@email.com'),
            ),
            const SizedBox(height: 20),

            _buildLabel('Senha'),
            const SizedBox(height: 8),
            _buildTextFieldSenha(),
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Telainicial()),),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Quero entrar sem cadastro',
                  style: TextStyle(fontSize: 14, color: blueMedium),
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _carregando ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: bluePetrol,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: _carregando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: beigeLight,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

  Widget _buildTextFieldSenha() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_senhaVisivel,
      validator: _validarSenha,
      decoration: _inputDecoration(
        'Senha',
        suffixIcon: IconButton(
          icon: Icon(
            _senhaVisivel ? Icons.visibility : Icons.visibility_off,
            color: blueMedium,
            size: 20,
          ),
          onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
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
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
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
}

/// InputFormatter que converte automaticamente letras maiúsculas
/// para minúsculas apenas na parte do nome do usuário (antes do @).
/// Após o @, o texto é preservado como digitado.
class _LowercaseBeforeAtFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final atIndex = text.indexOf('@');

    // Se ainda não digitou o @, converte tudo para minúsculo
    if (atIndex == -1) {
      final lower = text.toLowerCase();
      return newValue.copyWith(
        text: lower,
        selection: newValue.selection,
      );
    }

    // Converte só a parte antes do @ e mantém o restante intacto
    final nomeLower = text.substring(0, atIndex).toLowerCase();
    final resto = text.substring(atIndex);
    final resultado = nomeLower + resto;

    return newValue.copyWith(
      text: resultado,
      selection: newValue.selection,
    );
  }
}