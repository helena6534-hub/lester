import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class _UserModel {
  final String email;
  final String username;
  final String senha;
  final bool isLeitor;

  const _UserModel({
    required this.email,
    required this.username,
    required this.senha,
    required this.isLeitor,
  });
}


class _FakeUserRepository {
  static final _FakeUserRepository _instance = _FakeUserRepository._();
  _FakeUserRepository._();
  factory _FakeUserRepository() => _instance;

  final List<_UserModel> _users = [];


  String? cadastrar(_UserModel user) {
    final emailJaUsado = _users.any(
      (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );
    if (emailJaUsado) return 'Este e-mail já está cadastrado.';

    final usernameJaUsado = _users.any(
      (u) => u.username.toLowerCase() == user.username.toLowerCase(),
    );
    if (usernameJaUsado) return 'Este nome de usuário já está em uso.';

    _users.add(user);
    return null;
  }
}


class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  static const Color beigeLight  = Color(0xFFF5F3E7);
  static const Color blueLight   = Color(0xFFA3CEE8);
  static const Color blueMedium  = Color(0xFF7F97B8);
  static const Color bluePetrol  = Color(0xFF4A7C99);

  final _formKey    = GlobalKey<FormState>();
  final _emailCtrl  = TextEditingController();
  final _nomeCtrl   = TextEditingController();
  final _senhaCtrl  = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _isLeitor            = true;
  bool _senhaVisivel        = false;
  bool _confirmVisivel      = false;
  bool _carregando          = false;

  static final RegExp _emailRegex = RegExp(
    r'^[a-z0-9][a-z0-9\.\-\_]*@[a-z0-9][a-z0-9\.\-]*\.[a-z]{2,}$',
  );
  static final RegExp _temLetra    = RegExp(r'[a-zA-Z]');
  static final RegExp _temNumero   = RegExp(r'[0-9]');
  static final RegExp _temEspecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]');

  @override
  void dispose() {
    _emailCtrl.dispose();
    _nomeCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira seu e-mail';
    final partes = value.trim().split('@');
    if (partes.length != 2) return 'Insira um e-mail válido (ex: nome@dominio.com)';
    if (partes[0] != partes[0].toLowerCase()) {
      return 'O nome do usuário não pode conter letras maiúsculas';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Insira um e-mail válido (ex: nome@dominio.com)';
    }
    return null;
  }

  String? _validarNome(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira um nome de usuário';
    if (value.trim().length < 3) return 'O nome deve ter ao menos 3 caracteres';
    if (value.trim().length > 30) return 'O nome pode ter no máximo 30 caracteres';
    if (!RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(value.trim())) {
      return 'Use apenas letras, números, _ ou .';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, insira uma senha';
    if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
    if (!_temLetra.hasMatch(value))    return 'A senha deve conter ao menos uma letra';
    if (!_temNumero.hasMatch(value))   return 'A senha deve conter ao menos um número';
    if (!_temEspecial.hasMatch(value)) return 'A senha deve conter ao menos um caractere especial (!@#...)';
    return null;
  }

  String? _validarConfirmar(String? value) {
    if (value == null || value.isEmpty) return 'Por favor, confirme sua senha';
    if (value != _senhaCtrl.text) return 'As senhas não coincidem';
    return null;
  }

  void _handleCadastro() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    final erro = _FakeUserRepository().cadastrar(
      _UserModel(
        email:    _emailCtrl.text.trim(),
        username: _nomeCtrl.text.trim(),
        senha:    _senhaCtrl.text,
        isLeitor: _isLeitor,
      ),
    );

    setState(() => _carregando = false);

    if (erro != null) {
      _mostrarErro(erro);
      return;
    }

    _mostrarSucesso();
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _mostrarSucesso() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: bluePetrol),
            SizedBox(width: 8),
            Text('Cadastro realizado!', style: TextStyle(color: bluePetrol, fontSize: 18)),
          ],
        ),
        content: Text(
          'Bem-vindo, ${_nomeCtrl.text.trim()}!\n'
          'Seu cadastro como ${_isLeitor ? "Leitor" : "Escritor"} foi concluído.',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // fecha dialog
              Navigator.of(context).pop(); // volta ao login
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: bluePetrol,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Ir para o Login'),
          ),
        ],
      ),
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
                      const SizedBox(height: 24),
                      _buildHeader(),
                      const SizedBox(height: 24),
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
        Image.asset('imagens/username.png', width: 500),
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
                Icon(Icons.person_add_outlined, color: bluePetrol, size: 20),
                SizedBox(width: 8),
                Text(
                  'Cadastre-se',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: bluePetrol,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildToggle(),
            const SizedBox(height: 20),

            _buildLabel('E-mail'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [_LowercaseBeforeAtFormatter()],
              validator: _validarEmail,
              decoration: _inputDecoration('seu@email.com'),
            ),
            const SizedBox(height: 20),

            _buildLabel('Nome de usuário'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nomeCtrl,
              keyboardType: TextInputType.text,
              validator: _validarNome,
              decoration: _inputDecoration('ex: joao_silva'),
            ),
            const SizedBox(height: 20),

            _buildLabel('Senha'),
            const SizedBox(height: 8),
            _buildSenhaField(
              controller: _senhaCtrl,
              hint: 'Mínimo 6 caracteres',
              visivel: _senhaVisivel,
              onToggle: () => setState(() => _senhaVisivel = !_senhaVisivel),
              validator: _validarSenha,
            ),
            const SizedBox(height: 8),
            _buildDicaSenha(),
            const SizedBox(height: 20),

            _buildLabel('Confirmar senha'),
            const SizedBox(height: 8),
            _buildSenhaField(
              controller: _confirmCtrl,
              hint: 'Repita a senha',
              visivel: _confirmVisivel,
              onToggle: () => setState(() => _confirmVisivel = !_confirmVisivel),
              validator: _validarConfirmar,
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _carregando ? null : _handleCadastro,
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
                      'Cadastrar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      children: [
        _buildToggleBtn(label: 'Leitor',   ativo: _isLeitor,  onTap: () => setState(() => _isLeitor = true)),
        const SizedBox(width: 12),
        _buildToggleBtn(label: 'Escritor', ativo: !_isLeitor, onTap: () => setState(() => _isLeitor = false)),
      ],
    );
  }

  Widget _buildToggleBtn({
    required String label,
    required bool ativo,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: ativo ? bluePetrol : const Color(0xFFB8D4E5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: ativo ? Colors.white : bluePetrol,
                fontSize: 15,
                fontWeight: ativo ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDicaSenha() {
    final senha = _senhaCtrl.text;
    final temLetra    = _temLetra.hasMatch(senha);
    final temNumero   = _temNumero.hasMatch(senha);
    final temEspecial = _temEspecial.hasMatch(senha);
    final temTamanho  = senha.length >= 6;

    return ValueListenableBuilder(
      valueListenable: _senhaCtrl,
      builder: (_, __, ___) {
        final s = _senhaCtrl.text;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDicaItem('Ao menos 6 caracteres', s.length >= 6),
            _buildDicaItem('Ao menos uma letra',    _temLetra.hasMatch(s)),
            _buildDicaItem('Ao menos um número',    _temNumero.hasMatch(s)),
            _buildDicaItem('Ao menos um símbolo (!@#...)', _temEspecial.hasMatch(s)),
          ],
        );
      },
    );
  }

  Widget _buildDicaItem(String texto, bool ok) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle_outline : Icons.radio_button_unchecked,
            size: 14,
            color: ok ? Colors.green.shade600 : blueMedium,
          ),
          const SizedBox(width: 6),
          Text(
            texto,
            style: TextStyle(
              fontSize: 12,
              color: ok ? Colors.green.shade700 : blueMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSenhaField({
    required TextEditingController controller,
    required String hint,
    required bool visivel,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !visivel,
      validator: validator,
      onChanged: (_) => setState(() {}), 
      decoration: _inputDecoration(
        hint,
        suffixIcon: IconButton(
          icon: Icon(
            visivel ? Icons.visibility : Icons.visibility_off,
            color: blueMedium,
            size: 20,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Já tem uma conta? ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Fazer login',
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
}

class _LowercaseBeforeAtFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text    = newValue.text;
    final atIndex = text.indexOf('@');

    if (atIndex == -1) {
      final lower = text.toLowerCase();
      return newValue.copyWith(text: lower, selection: newValue.selection);
    }

    final nomeLower = text.substring(0, atIndex).toLowerCase();
    final resto     = text.substring(atIndex);
    return newValue.copyWith(
      text: nomeLower + resto,
      selection: newValue.selection,
    );
  }
}