import 'package:flutter/material.dart';

class TelaCapitulos extends StatefulWidget {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color cardBg = Color(0xFFD4E8EE);

  /// Título do livro, mostrado na página de capa.
  final String tituloLivro;

  /// Texto da sinopse, mostrado na primeira página.
  final String sinopse;

  // Lista de capítulos de exemplo — troque pela lista real do seu livro.
  final List<Map<String, dynamic>> capitulos;

  // Em qual capítulo o leitor deve abrir (opcional, 0 = primeiro capítulo).
  final int capituloInicial;

  const TelaCapitulos({
    super.key,
    this.tituloLivro = 'Título do Livro',
    this.sinopse = 'Sinopse do livro ainda não disponível.',
    this.capitulos = const [
      {'titulo': 'Capítulo 1', 'texto': ''},
    ],
    this.capituloInicial = 0,
  });

  @override
  State<TelaCapitulos> createState() => _TelaCapitulosState();
}

class _TelaCapitulosState extends State<TelaCapitulos> {
  late final PageController _pageController;
  late int _paginaAtual;

  // A página 0 é sempre a sinopse. Os capítulos vêm depois.
  int get _totalPaginas => widget.capitulos.length + 1;

  @override
  void initState() {
    super.initState();
    _paginaAtual = (widget.capituloInicial + 1).clamp(0, _totalPaginas - 1);
    _pageController = PageController(initialPage: _paginaAtual);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _irPara(int index) {
    if (index < 0 || index >= _totalPaginas) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String get _tituloCabecalho {
    if (_paginaAtual == 0) return widget.tituloLivro;
    final cap = widget.capitulos[_paginaAtual - 1];
    return cap['titulo'] as String? ?? 'Capítulo $_paginaAtual';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TelaCapitulos.bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildIndicadorPagina(),
            const SizedBox(height: 12),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPaginas,
                onPageChanged: (index) => setState(() => _paginaAtual = index),
                itemBuilder: (context, index) {
                  if (index == 0) return _buildPaginaCapa();
                  return _buildPaginaCapitulo(index - 1);
                },
              ),
            ),
            const SizedBox(height: 8),
            _buildBarraNavegacao(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: TelaCapitulos.bluePetrol,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _tituloCabecalho,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TelaCapitulos.bluePetrol,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildIndicadorPagina() {
    final label = _paginaAtual == 0
        ? 'Sinopse'
        : 'Capítulo $_paginaAtual de ${widget.capitulos.length}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => _irPara(0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: TelaCapitulos.cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: TelaCapitulos.textBlue,
            ),
          ),
        ),
      ),
    );
  }

  // Página inicial: apenas a sinopse.
  Widget _buildPaginaCapa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: TelaCapitulos.blueLight,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SINOPSE',
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  color: TelaCapitulos.textBlue.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 1.5,
                color: TelaCapitulos.blueLight.withOpacity(0.4),
              ),
              const SizedBox(height: 16),
              Text(
                widget.sinopse,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D3748),
                  height: 1.8,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaginaCapitulo(int index) {
    final cap = widget.capitulos[index];
    final titulo = cap['titulo'] as String? ?? 'Capítulo ${index + 1}';
    final texto = (cap['texto'] as String? ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: TelaCapitulos.blueLight, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capítulo ${index + 1}',
                style: TextStyle(
                  fontSize: 13,
                  color: TelaCapitulos.textBlue.withOpacity(0.6),
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: TelaCapitulos.bluePetrol,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 1.5,
                color: TelaCapitulos.blueLight.withOpacity(0.4),
              ),
              const SizedBox(height: 20),
              Text(
                texto.trim().isEmpty
                    ? 'Este capítulo ainda não possui conteúdo.'
                    : texto,
                style: TextStyle(
                  fontSize: 16,
                  color: texto.trim().isEmpty
                      ? Colors.grey.shade400
                      : const Color(0xFF2D3748),
                  height: 1.8,
                  letterSpacing: 0.3,
                  fontStyle: texto.trim().isEmpty
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarraNavegacao() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: _BotaoNavegacao(
              icone: Icons.arrow_back_ios_new,
              label: 'Anterior',
              ativo: _paginaAtual > 0,
              alinhamento: MainAxisAlignment.start,
              onTap: () => _irPara(_paginaAtual - 1),
            ),
          ),
          const SizedBox(width: 12),

          // Pontinhos indicadores (com scroll horizontal caso tenha muitos capítulos)
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_totalPaginas, (i) {
                  final ativo = i == _paginaAtual;
                  return GestureDetector(
                    onTap: () => _irPara(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: ativo ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: ativo
                            ? TelaCapitulos.bluePetrol
                            : TelaCapitulos.blueLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: _BotaoNavegacao(
              icone: Icons.arrow_forward_ios,
              label: 'Próxima',
              ativo: _paginaAtual < _totalPaginas - 1,
              alinhamento: MainAxisAlignment.end,
              onTap: () => _irPara(_paginaAtual + 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _BotaoNavegacao extends StatelessWidget {
  final IconData icone;
  final String label;
  final bool ativo;
  final MainAxisAlignment alinhamento;
  final VoidCallback onTap;

  const _BotaoNavegacao({
    required this.icone,
    required this.label,
    required this.ativo,
    required this.alinhamento,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Botão ativo: fundo azul cheio + texto branco (fica claro que é clicável).
    // Botão inativo: fundo claro + texto apagado (fica claro que está desabilitado).
    final corTexto = ativo ? Colors.white : TelaCapitulos.blueLight.withOpacity(0.7);
    final corFundo = ativo ? TelaCapitulos.bluePetrol : TelaCapitulos.cardBg;

    final filhos = alinhamento == MainAxisAlignment.start
        ? [
            Icon(icone, size: 16, color: corTexto),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: corTexto, fontWeight: FontWeight.w600)),
          ]
        : [
            Text(label, style: TextStyle(color: corTexto, fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            Icon(icone, size: 16, color: corTexto),
          ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ativo ? onTap : null,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: corFundo,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(mainAxisAlignment: alinhamento, children: filhos),
        ),
      ),
    );
  }
}