import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
//  CONTROLLER COM RICH TEXT (negrito / itálico / sublinhado)
//  Interpreta marcadores **texto**, _texto_ e __texto__
//  e renderiza formatado em tempo real dentro do TextField.
// ─────────────────────────────────────────────
class RichTextEditingController extends TextEditingController {
  RichTextEditingController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<InlineSpan> spans = [];
    final String source = text;

    // Regex que captura, em ordem: __sublinhado__, **negrito**, _itálico_
    final RegExp pattern = RegExp(
      r'(__.+?__)|(\*\*.+?\*\*)|(_.+?_)',
      dotAll: true,
    );

    int last = 0;
    for (final match in pattern.allMatches(source)) {
      if (match.start > last) {
        spans.add(
          TextSpan(text: source.substring(last, match.start), style: style),
        );
      }

      final String token = match.group(0)!;

      if (token.startsWith('__')) {
        // sublinhado __texto__
        final inner = token.substring(2, token.length - 2);
        spans.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: style.color,
            ),
          ),
        );
        // sobrescreve para mostrar somente o conteúdo de forma decorada
        spans.removeLast();
        spans.add(
          TextSpan(
            children: [
              TextSpan(
                text: '__',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
              TextSpan(
                text: inner,
                style: style?.copyWith(decoration: TextDecoration.underline),
              ),
              TextSpan(
                text: '__',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
            ],
          ),
        );
      } else if (token.startsWith('**')) {
        // negrito **texto**
        final inner = token.substring(2, token.length - 2);
        spans.add(
          TextSpan(
            children: [
              TextSpan(
                text: '**',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
              TextSpan(
                text: inner,
                style: style?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '**',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
            ],
          ),
        );
      } else {
        // itálico _texto_
        final inner = token.substring(1, token.length - 1);
        spans.add(
          TextSpan(
            children: [
              TextSpan(
                text: '_',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
              TextSpan(
                text: inner,
                style: style?.copyWith(fontStyle: FontStyle.italic),
              ),
              TextSpan(
                text: '_',
                style: style?.copyWith(color: style.color?.withOpacity(0.25)),
              ),
            ],
          ),
        );
      }

      last = match.end;
    }

    if (last < source.length) {
      spans.add(TextSpan(text: source.substring(last), style: style));
    }

    if (spans.isEmpty) {
      return TextSpan(text: source, style: style);
    }

    return TextSpan(style: style, children: spans);
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
  late RichTextEditingController _textoController;
  late FocusNode _textoFocus;

  bool _isEditingTitle = false;
  bool _showToolbar = true;
  double _fontSize = 16;
  TextAlign _alinhamento = TextAlign.left;

  // Histórico para desfazer / refazer
  final List<TextEditingValue> _historico = [];
  int _historicoIndex = -1;
  bool _ignorarMudanca = false;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.titulo);
    _textoController = RichTextEditingController(text: widget.texto);
    _textoFocus = FocusNode();
    _textoFocus.addListener(() => setState(() {}));

    // estado inicial no histórico
    _historico.add(_textoController.value);
    _historicoIndex = 0;

    _textoController.addListener(_onTextoMudou);
  }

  @override
  void dispose() {
    _textoController.removeListener(_onTextoMudou);
    _tituloController.dispose();
    _textoController.dispose();
    _textoFocus.dispose();
    super.dispose();
  }

  void _onTextoMudou() {
    if (_ignorarMudanca) return;

    final atual = _textoController.value;

    // Evita duplicar entradas idênticas no histórico
    if (_historicoIndex >= 0 &&
        _historico[_historicoIndex].text == atual.text) {
      _historico[_historicoIndex] = atual;
      return;
    }

    // Se estávamos no meio do histórico (após um undo), descarta o futuro
    if (_historicoIndex < _historico.length - 1) {
      _historico.removeRange(_historicoIndex + 1, _historico.length);
    }

    _historico.add(atual);
    _historicoIndex = _historico.length - 1;

    // Limita o tamanho do histórico
    if (_historico.length > 100) {
      _historico.removeAt(0);
      _historicoIndex--;
    }

    setState(() {});
  }

  void _desfazer() {
    if (_historicoIndex <= 0) return;
    _historicoIndex--;
    _ignorarMudanca = true;
    _textoController.value = _historico[_historicoIndex];
    _ignorarMudanca = false;
    setState(() {});
  }

  void _refazer() {
    if (_historicoIndex >= _historico.length - 1) return;
    _historicoIndex++;
    _ignorarMudanca = true;
    _textoController.value = _historico[_historicoIndex];
    _ignorarMudanca = false;
    setState(() {});
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

  void _aplicarMarcador(String marcadorAbre, String marcadorFecha) {
    final ctrl = _textoController;
    final sel = ctrl.selection;
    final texto = ctrl.text;

    final base = sel.isValid ? sel.start : texto.length;
    final ext = sel.isValid ? sel.end : texto.length;

    final selecionado = texto.substring(base, ext);

    String novoTrecho;
    int novoCursorInicio;
    int novoCursorFim;

    if (selecionado.isNotEmpty) {
      novoTrecho = '$marcadorAbre$selecionado$marcadorFecha';
      novoCursorInicio = base + novoTrecho.length;
      novoCursorFim = novoCursorInicio;
    } else {
      const placeholder = 'texto';
      novoTrecho = '$marcadorAbre$placeholder$marcadorFecha';
      novoCursorInicio = base + marcadorAbre.length;
      novoCursorFim = novoCursorInicio + placeholder.length;
    }

    final novoTexto = texto.replaceRange(base, ext, novoTrecho);

    ctrl.value = TextEditingValue(
      text: novoTexto,
      selection: TextSelection(
        baseOffset: novoCursorInicio,
        extentOffset: novoCursorFim,
      ),
    );

    _textoFocus.requestFocus();
  }

  void _inserirNaLinha(String prefixo) {
    final ctrl = _textoController;
    final texto = ctrl.text;
    final sel = ctrl.selection;

    int offset = sel.isValid ? sel.start : texto.length;

    final precisaQuebra = offset > 0 && texto[offset - 1] != '\n';
    final inserir = (precisaQuebra ? '\n' : '') + prefixo;

    final novoTexto = texto.replaceRange(offset, offset, inserir);
    final novoOffset = offset + inserir.length;

    ctrl.value = TextEditingValue(
      text: novoTexto,
      selection: TextSelection.collapsed(offset: novoOffset),
    );

    _textoFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final podeDesfazer = _historicoIndex > 0;
    final podeRefazer = _historicoIndex < _historico.length - 1;

    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER DO EDITOR ─────────────────────────
            Container(
              color: bgBeige,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _salvar,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: bluePetrol,
                    ),
                  ),

                  Expanded(
                    child: _isEditingTitle
                        ? TextField(
                            controller: _tituloController,
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bluePetrol,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onSubmitted: (_) =>
                                setState(() => _isEditingTitle = false),
                          )
                        : GestureDetector(
                            onTap: () => setState(() => _isEditingTitle = true),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    _tituloController.text,
                                    style: const TextStyle(
                                      fontSize: 16,
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

                  const SizedBox(width: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_palavras pal.',
                      style: const TextStyle(
                        fontSize: 11,
                        color: textBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  TextButton(
                    onPressed: _salvar,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: const Size(0, 40),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: bluePetrol,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── BARRA DE FORMATAÇÃO (estilo Word) ────────
            if (_showToolbar)
              Container(
                color: const Color(0xFFD4E8EE),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final botoes = <Widget>[
                      _ToolBtn(
                        icon: Icons.remove,
                        tooltip: 'Diminuir fonte',
                        onTap: () => setState(() {
                          if (_fontSize > 12) _fontSize -= 2;
                        }),
                      ),
                      _IndicadorFonte(tamanho: _fontSize.toInt()),
                      _ToolBtn(
                        icon: Icons.add,
                        tooltip: 'Aumentar fonte',
                        onTap: () => setState(() {
                          if (_fontSize < 28) _fontSize += 2;
                        }),
                      ),
                      _ribbonDivider(),
                      _ToolBtn(
                        label: 'B',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        tooltip: 'Negrito',
                        onTap: () => _aplicarMarcador('**', '**'),
                      ),
                      _ToolBtn(
                        label: 'I',
                        labelStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontFamily: 'serif',
                        ),
                        tooltip: 'Itálico',
                        onTap: () => _aplicarMarcador('_', '_'),
                      ),
                      _ToolBtn(
                        label: 'U',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        tooltip: 'Sublinhado',
                        onTap: () => _aplicarMarcador('__', '__'),
                      ),
                      _ribbonDivider(),
                      _ToolBtn(
                        icon: Icons.format_align_left,
                        tooltip: 'Alinhar à esquerda',
                        ativo: _alinhamento == TextAlign.left,
                        onTap: () =>
                            setState(() => _alinhamento = TextAlign.left),
                      ),
                      _ToolBtn(
                        icon: Icons.format_align_center,
                        tooltip: 'Centralizar',
                        ativo: _alinhamento == TextAlign.center,
                        onTap: () =>
                            setState(() => _alinhamento = TextAlign.center),
                      ),
                      _ToolBtn(
                        icon: Icons.format_align_right,
                        tooltip: 'Alinhar à direita',
                        ativo: _alinhamento == TextAlign.right,
                        onTap: () =>
                            setState(() => _alinhamento = TextAlign.right),
                      ),
                      _ToolBtn(
                        icon: Icons.format_align_justify,
                        tooltip: 'Justificar',
                        ativo: _alinhamento == TextAlign.justify,
                        onTap: () =>
                            setState(() => _alinhamento = TextAlign.justify),
                      ),
                      _ribbonDivider(),
                      _ToolBtn(
                        icon: Icons.format_quote,
                        tooltip: 'Citação',
                        onTap: () => _inserirNaLinha('"texto"\n'),
                      ),
                      _ToolBtn(
                        icon: Icons.horizontal_rule,
                        tooltip: 'Separador',
                        onTap: () => _inserirNaLinha('* * *\n'),
                      ),
                      _ribbonDivider(),
                      _ToolBtn(
                        icon: Icons.undo,
                        tooltip: 'Desfazer',
                        onTap: podeDesfazer ? _desfazer : null,
                      ),
                      _ToolBtn(
                        icon: Icons.redo,
                        tooltip: 'Refazer',
                        onTap: podeRefazer ? _refazer : null,
                      ),
                    ];

                    const larguraDivisor = 5.0;
                    const larguraIndicador = 20.0;

                    int qtdBotoes = 0;
                    double larguraFixaTotal = 0;
                    for (final item in botoes) {
                      if (item is _ToolBtn) {
                        qtdBotoes++;
                      } else if (item is _IndicadorFonte) {
                        larguraFixaTotal += larguraIndicador;
                      } else {
                        larguraFixaTotal += larguraDivisor;
                      }
                    }

                    final larguraDisponivel = constraints.maxWidth;
                    final larguraRestante =
                        larguraDisponivel - larguraFixaTotal;
                    final larguraPorBotao = qtdBotoes > 0
                        ? (larguraRestante / qtdBotoes).clamp(18.0, 36.0)
                        : 36.0;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: botoes.map((w) {
                        if (w is _ToolBtn) {
                          return SizedBox(width: larguraPorBotao, child: w);
                        }
                        return w;
                      }).toList(),
                    );
                  },
                ),
              ),

            // ── ÁREA DE ESCRITA ──────────────────────────
            Expanded(
              child: Container(
                color: Colors.white, // <-- alterado de Color(0xFFEAF4FB) para branco
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

                      TextField(
                        controller: _textoController,
                        focusNode: _textoFocus,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: _alinhamento,
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

class _IndicadorFonte extends StatelessWidget {
  final int tamanho;

  const _IndicadorFonte({required this.tamanho});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Text(
        '$tamanho',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D3748),
        ),
      ),
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;
  final bool ativo;
  final String? tooltip;

  const _ToolBtn({
    this.icon,
    this.label,
    this.labelStyle,
    required this.onTap,
    this.ativo = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final bool desabilitado = onTap == null;

    final Color corConteudo = desabilitado
        ? const Color(0xFFBFBFBF)
        : (ativo ? const Color(0xFF185FA5) : const Color(0xFF2D3748));

    Widget conteudo;
    if (label != null) {
      conteudo = Text(
        label!,
        style: (labelStyle ?? const TextStyle(fontSize: 16)).copyWith(
          color: corConteudo,
        ),
      );
    } else {
      conteudo = Icon(icon, size: 19, color: corConteudo);
    }

    final botao = Container(
      width: 34,
      height: 34,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ativo ? Colors.white : null,
        border: ativo
            ? Border.all(color: const Color(0xFF7FB8D6), width: 1)
            : null,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: conteudo,
    );

    return Tooltip(
      message: tooltip ?? '',
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: botao,
      ),
    );
  }
}

Widget _ribbonDivider() => Container(
  width: 1,
  height: 28,
  color: const Color(0xFFA3CEE8),
  margin: const EdgeInsets.symmetric(horizontal: 2),
);