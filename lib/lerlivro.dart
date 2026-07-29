import 'package:flutter/material.dart';

class TelaCapitulos extends StatefulWidget {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color cardBg = Color(0xFFD4E8EE);

  // Lista de capítulos de exemplo — troque pela lista real do seu livro.
  final List<Map<String, dynamic>> capitulos;

  // Em qual capítulo o leitor deve abrir (opcional).
  final int capituloInicial;

  const TelaCapitulos({
    super.key,
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

  @override
  void initState() {
    super.initState();
    _paginaAtual = widget.capituloInicial.clamp(
      0,
      widget.capitulos.length - 1,
    );
    _pageController = PageController(initialPage: _paginaAtual);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _irPara(int index) {
    if (index < 0 || index >= widget.capitulos.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.capitulos.length;

    return Scaffold(
      backgroundColor: TelaCapitulos.bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: TelaCapitulos.bluePetrol,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.capitulos[_paginaAtual]['titulo']
                                as String? ??
                            'Capítulo ${_paginaAtual + 1}',
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
            ),

            // Indicador de página (ex.: "3 de 12")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: TelaCapitulos.cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Capítulo ${_paginaAtual + 1} de $total',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: TelaCapitulos.textBlue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Páginas do livro (uma por capítulo, com swipe)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: total,
                onPageChanged: (index) {
                  setState(() => _paginaAtual = index);
                },
                itemBuilder: (context, index) {
                  final cap = widget.capitulos[index];
                  final titulo =
                      cap['titulo'] as String? ?? 'Capítulo ${index + 1}';
                  final texto = (cap['texto'] as String? ?? '');

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
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
                },
              ),
            ),

            const SizedBox(height: 8),

            // Barra de navegação: voltar / avançar página
            Padding(
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

                  // Pontinhos indicadores
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(total, (i) {
                      final ativo = i == _paginaAtual;
                      return AnimatedContainer(
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
                      );
                    }),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: _BotaoNavegacao(
                      icone: Icons.arrow_forward_ios,
                      label: 'Próxima',
                      ativo: _paginaAtual < total - 1,
                      alinhamento: MainAxisAlignment.end,
                      onTap: () => _irPara(_paginaAtual + 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
    final cor = ativo
        ? TelaCapitulos.bluePetrol
        : TelaCapitulos.blueLight.withOpacity(0.5);

    final filhos = alinhamento == MainAxisAlignment.start
        ? [
            Icon(icone, size: 16, color: cor),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: cor, fontWeight: FontWeight.w600)),
          ]
        : [
            Text(label, style: TextStyle(color: cor, fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            Icon(icone, size: 16, color: cor),
          ];

    return InkWell(
      onTap: ativo ? onTap : null,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: TelaCapitulos.cardBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(mainAxisAlignment: alinhamento, children: filhos),
      ),
    );
  }
}