import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Publique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F3E7),
      ),
      home: const Publique(),
    );
  }
}

// ─────────────────────────────────────────────
//  TELA 1 — Detalhes do livro (capa, título, sinopse)
// ─────────────────────────────────────────────
class Publique extends StatefulWidget {
  const Publique({super.key});

  @override
  State<Publique> createState() => _PubliqueState();
}

class _PubliqueState extends State<Publique> {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color cardBg = Color(0xFFD4E8EE);

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _sinopseController = TextEditingController();

  // Lista de capítulos com seus textos
  final List<Map<String, dynamic>> _capitulos = [
    {'titulo': 'Capítulo 1', 'texto': ''},
  ];

  @override
  void dispose() {
    _tituloController.dispose();
    _sinopseController.dispose();
    super.dispose();
  }

  void _adicionarCapitulo() {
    setState(() {
      _capitulos.add({
        'titulo': 'Capítulo ${_capitulos.length + 1}',
        'texto': '',
      });
    });
  }

  int get _totalPalavras {
    return _capitulos.fold(0, (sum, cap) {
      final texto = (cap['texto'] as String).trim();
      if (texto.isEmpty) return sum;
      return sum + texto.split(RegExp(r'\s+')).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ──────────────────────────────────
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
                        'Publique',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // ── CAPA ────────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 130,
                          height: 170,
                          decoration: BoxDecoration(
                            color: bluePetrol,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: bluePetrol.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: blueLight.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── TÍTULO ──────────────────────────
                    _buildField(
                      _tituloController,
                      'Inserir Título',
                      bgBeige,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),

                    // ── SINOPSE ─────────────────────────
                    _buildField(
                      _sinopseController,
                      'Sinopse:',
                      cardBg,
                      maxLines: 8,
                    ),
                    const SizedBox(height: 24),

                    // ── ESTATÍSTICAS ────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat('${_capitulos.length}', 'capítulos'),
                          Container(width: 1, height: 32, color: blueLight),
                          _buildStat('$_totalPalavras', 'palavras'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── LISTA DE CAPÍTULOS ───────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Capítulos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: bluePetrol,
                          ),
                        ),
                        GestureDetector(
                          onTap: _adicionarCapitulo,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: blueLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.add, size: 16, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'Novo capítulo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Cards dos capítulos
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _capitulos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final cap = _capitulos[index];
                        final palavras = (cap['texto'] as String).trim().isEmpty
                            ? 0
                            : (cap['texto'] as String)
                                  .trim()
                                  .split(RegExp(r'\s+'))
                                  .length;

                        return GestureDetector(
                          onTap: () async {
                            final resultado =
                                await Navigator.push<Map<String, String>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditorCapitulo(
                                      titulo: cap['titulo'] as String,
                                      texto: cap['texto'] as String,
                                      numero: index + 1,
                                    ),
                                  ),
                                );
                            if (resultado != null) {
                              setState(() {
                                _capitulos[index]['titulo'] =
                                    resultado['titulo']!;
                                _capitulos[index]['texto'] =
                                    resultado['texto']!;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: blueLight, width: 1.2),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: bluePetrol,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cap['titulo'] as String,
                                        style: TextStyle(
                                          color: bluePetrol,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        palavras == 0
                                            ? 'Vazio — toque para escrever'
                                            : '$palavras palavras',
                                        style: TextStyle(
                                          color: textBlue.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: blueLight),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),

            // ── BOTÃO PUBLICAR ──────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
                    'Publicar',
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

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    Color bg, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA3CEE8), width: 1.5),
      ),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: maxLines > 1,
          labelStyle: const TextStyle(color: Color(0xFF5B8FA3), fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Color(0xFF5B8FA3)),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A7C99),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: const Color(0xFF5B8FA3).withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TELA 2 — Editor de capítulo (estilo Wattpad)
// ─────────────────────────────────────────────
class EditorCapitulo extends StatefulWidget {
  final String titulo;
  final String texto;
  final int numero;

  const EditorCapitulo({
    super.key,
    required this.titulo,
    required this.texto,
    required this.numero,
  });

  @override
  State<EditorCapitulo> createState() => _EditorCapituloState();
}

class _EditorCapituloState extends State<EditorCapitulo> {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);
  static const Color cardBg = Color(0xFFD4E8EE);

  late TextEditingController _tituloController;
  late TextEditingController _textoController;
  late FocusNode _textoFocus;

  bool _isEditingTitle = false;
  bool _showToolbar = true;
  double _fontSize = 16;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.titulo);
    _textoController = TextEditingController(text: widget.texto);
    _textoFocus = FocusNode();
    _textoFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _textoController.dispose();
    _textoFocus.dispose();
    super.dispose();
  }

  int get _palavras {
    final t = _textoController.text.trim();
    if (t.isEmpty) return 0;
    return t.split(RegExp(r'\s+')).length;
  }

  int get _caracteres => _textoController.text.length;

  void _salvar() {
    Navigator.pop(context, {
      'titulo': _tituloController.text,
      'texto': _textoController.text,
    });
  }

  void _inserirTexto(String snippet) {
    final ctrl = _textoController;
    final sel = ctrl.selection;
    final base = sel.isValid ? sel.baseOffset : ctrl.text.length;
    final ext = sel.isValid ? sel.extentOffset : ctrl.text.length;
    final novoTexto =
        ctrl.text.substring(0, base) + snippet + ctrl.text.substring(ext);
    ctrl.value = TextEditingValue(
      text: novoTexto,
      selection: TextSelection.collapsed(offset: base + snippet.length),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER DO EDITOR ─────────────────────────
            Container(
              color: bgBeige,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _salvar,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: bluePetrol,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _isEditingTitle
                        ? TextField(
                            controller: _tituloController,
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: bluePetrol,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onSubmitted: (_) =>
                                setState(() => _isEditingTitle = false),
                          )
                        : GestureDetector(
                            onTap: () => setState(() => _isEditingTitle = true),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    _tituloController.text,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: bluePetrol,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: blueLight,
                                ),
                              ],
                            ),
                          ),
                  ),
                  // Contador de palavras
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_palavras pal.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: textBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Salvar
                  TextButton(
                    onPressed: _salvar,
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: bluePetrol,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── BARRA DE FORMATAÇÃO (estilo Wattpad) ─────
            if (_showToolbar)
              Container(
                color: cardBg,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Tamanho da fonte −
                      _ToolBtn(
                        icon: Icons.text_decrease,
                        onTap: () => setState(() {
                          if (_fontSize > 12) _fontSize -= 2;
                        }),
                      ),
                      // Tamanho da fonte +
                      _ToolBtn(
                        icon: Icons.text_increase,
                        onTap: () => setState(() {
                          if (_fontSize < 28) _fontSize += 2;
                        }),
                      ),
                      _divider(),
                      // Negrito (simulado com **texto**)
                      _ToolBtn(
                        icon: Icons.format_bold,
                        onTap: () => _inserirTexto('**texto**'),
                      ),
                      // Itálico
                      _ToolBtn(
                        icon: Icons.format_italic,
                        onTap: () => _inserirTexto('_texto_'),
                      ),
                      // Sublinhado
                      _ToolBtn(
                        icon: Icons.format_underline,
                        onTap: () => _inserirTexto('__texto__'),
                      ),
                      _divider(),
                      // Alinhamento
                      _ToolBtn(icon: Icons.format_align_left, onTap: () {}),
                      _ToolBtn(icon: Icons.format_align_center, onTap: () {}),
                      _ToolBtn(icon: Icons.format_align_right, onTap: () {}),
                      _divider(),
                      // Citação
                      _ToolBtn(
                        icon: Icons.format_quote,
                        onTap: () => _inserirTexto('\n""\n'),
                      ),
                      // Quebra de linha / separador
                      _ToolBtn(
                        icon: Icons.horizontal_rule,
                        onTap: () => _inserirTexto('\n* * *\n'),
                      ),
                      // Desfazer
                      _ToolBtn(icon: Icons.undo, onTap: () {}),
                      // Refazer
                      _ToolBtn(icon: Icons.redo, onTap: () {}),
                    ],
                  ),
                ),
              ),

            // ── ÁREA DE ESCRITA ──────────────────────────
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Número do capítulo
                      Text(
                        'Capítulo ${widget.numero}',
                        style: TextStyle(
                          fontSize: 13,
                          color: textBlue.withOpacity(0.6),
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Título editável inline
                      GestureDetector(
                        onTap: () => setState(() => _isEditingTitle = true),
                        child: Text(
                          _tituloController.text,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: bluePetrol,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Divisor decorativo
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.5,
                              color: blueLight.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // CAMPO DE TEXTO PRINCIPAL — grande como o Wattpad
                      TextField(
                        controller: _textoController,
                        focusNode: _textoFocus,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (_) => setState(() {}),
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: const Color(0xFF2D3748),
                          height: 1.8,
                          letterSpacing: 0.3,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Comece a escrever o seu capítulo aqui...\n\nDeixe sua imaginação fluir.',
                          hintStyle: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.grey.shade400,
                            height: 1.8,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── RODAPÉ DO EDITOR ─────────────────────────
            Container(
              color: bgBeige,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_caracteres caracteres',
                    style: TextStyle(
                      fontSize: 12,
                      color: textBlue.withOpacity(0.7),
                    ),
                  ),
                  // Toggle da barra de ferramentas
                  GestureDetector(
                    onTap: () => setState(() => _showToolbar = !_showToolbar),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _showToolbar ? blueLight : cardBg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            size: 14,
                            color: _showToolbar ? Colors.white : textBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Ferramentas',
                            style: TextStyle(
                              fontSize: 12,
                              color: _showToolbar ? Colors.white : textBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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

// Botão da barra de ferramentas
class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ToolBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 20, color: const Color(0xFF4A7C99)),
      ),
    );
  }
}

Widget _divider() => Container(
  width: 1,
  height: 24,
  color: const Color(0xFFA3CEE8),
  margin: const EdgeInsets.symmetric(horizontal: 4),
);
