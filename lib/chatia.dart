import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicas com IA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  static const Color beigeLight = Color(0xFFF5F3E7);
  static const Color beigeMid   = Color(0xFFEDE9D5);
  static const Color beigeWarm  = Color(0xFFD9D2B6);
  static const Color blueLight  = Color(0xFFA3CEE8);
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue   = Color(0xFF5B8FA3);
  static const Color salmon     = Color(0xFFE89A7D);

  
  static const String _apiKey = 'AIzaSyD6lPwZ_6vCMgUhcK7jAUR8Uh6y2s9y5fk';
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/'
      'gemini-2.0-flash:generateContent?key=$_apiKey';

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Message> _messages = [];
  bool _isLoading = false;

  Future<void> _enviarMensagem() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_Message(text: text, isIA: false));
      _controller.clear();
      _isLoading = true;
    });
    _scrollToBottom();

    final List<Map<String, dynamic>> contents = _messages.map((m) => {
      'role': m.isIA ? 'model' : 'user',
      'parts': [{'text': m.text}],
    }).toList();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'contents': contents}),
      ).timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final reply =
            data['candidates']?[0]?['content']?['parts']?[0]?['text']
                as String? ?? 'Sem resposta.';
        setState(() {
          _messages.add(_Message(text: reply.trim(), isIA: true));
        });
      } else {
        final errMsg = data['error']?['message'] ?? 'Erro ${response.statusCode}';
        final errCode = data['error']?['status'] ?? '';
        String userMsg = '⚠️ Erro da API: $errMsg';

        if (errCode == 'UNAUTHENTICATED' || response.statusCode == 400 || response.statusCode == 403) {
          userMsg += '\n\n🔑 Sua chave de API parece inválida.\n'
              'Acesse aistudio.google.com/app/apikey, gere uma chave '
              '(começa com "AIza...") e cole no código.';
        }

        setState(() {
          _messages.add(_Message(text: userMsg, isIA: true));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(_Message(
          text: '⚠️ Falha de conexão: $e',
          isIA: true,
        ));
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [beigeLight, beigeMid, beigeWarm, blueLight],
            stops: [0.0, 0.50, 0.80, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: bluePetrol, size: 26),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Dicas com IA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: bluePetrol,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: blueLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: bluePetrol, width: 2),
                      ),
                      child: const Icon(Icons.psychology, color: bluePetrol, size: 22),
                    ),
                  ],
                ),
              ),

              // Mensagens
              Expanded(
                child: _messages.isEmpty && !_isLoading
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: _messages.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length) return _buildTypingIndicator();
                          return _buildBubble(_messages[index]);
                        },
                      ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: beigeLight,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: bluePetrol.withOpacity(0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: bluePetrol.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: textBlue, fontSize: 15),
                        decoration: const InputDecoration(
                          hintText: 'Pergunte algo à IA...',
                          hintStyle: TextStyle(color: Color(0xFF9BB8C9)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onSubmitted: (_) => _enviarMensagem(),
                        enabled: !_isLoading,
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                    GestureDetector(
                      onTap: _isLoading ? null : _enviarMensagem,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isLoading ? bluePetrol.withOpacity(0.4) : bluePetrol,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              color: blueLight.withOpacity(0.5),
              shape: BoxShape.circle,
              border: Border.all(color: bluePetrol, width: 2),
            ),
            child: const Icon(Icons.psychology, color: bluePetrol, size: 38),
          ),
          const SizedBox(height: 16),
          const Text('Olá! Como posso ajudar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: bluePetrol)),
          const SizedBox(height: 8),
          const Text('Digite sua pergunta abaixo.',
              style: TextStyle(fontSize: 14, color: textBlue)),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 34, height: 34,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: blueLight,
              shape: BoxShape.circle,
              border: Border.all(color: bluePetrol, width: 1.5),
            ),
            child: const Icon(Icons.psychology, color: bluePetrol, size: 18),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: beigeLight.withOpacity(0.88),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: bluePetrol.withOpacity(0.15), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _Dot(delay: Duration(milliseconds: i * 180))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(_Message msg) {
    final isIA = msg.isIA;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isIA ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isIA) ...[
            Container(
              width: 34, height: 34,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: blueLight,
                shape: BoxShape.circle,
                border: Border.all(color: bluePetrol, width: 1.5),
              ),
              child: const Icon(Icons.psychology, color: bluePetrol, size: 18),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isIA ? beigeLight.withOpacity(0.92) : bluePetrol.withOpacity(0.85),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isIA ? 4 : 18),
                  bottomRight: Radius.circular(isIA ? 18 : 4),
                ),
                border: isIA ? Border.all(color: bluePetrol.withOpacity(0.15), width: 1) : null,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Text(
                msg.text,
                style: TextStyle(fontSize: 15, color: isIA ? textBlue : beigeLight, height: 1.45),
              ),
            ),
          ),
          if (!isIA) ...[
            Container(
              width: 34, height: 34,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: salmon,
                shape: BoxShape.circle,
                border: Border.all(color: bluePetrol, width: 1.5),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isIA;
  _Message({required this.text, required this.isIA});
}

class _Dot extends StatefulWidget {
  final Duration delay;
  const _Dot({required this.delay});
  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  static const Color bluePetrol = Color(0xFF4A7C99);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _anim = Tween(begin: 0.0, end: -6.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.repeat(reverse: true); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: Container(
          width: 7, height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(color: bluePetrol.withOpacity(0.6), shape: BoxShape.circle),
        ),
      ),
    );
  }
}