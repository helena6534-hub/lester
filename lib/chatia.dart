import 'package:flutter/material.dart';

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
  static const Color blueLight  = Color(0xFFA3CEE8);
  static const Color blueMedium = Color(0xFF6A9BB9);
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue   = Color(0xFF5B8FA3);
  static const Color salmon     = Color(0xFFE89A7D);

  final TextEditingController _controller = TextEditingController();

  final List<_Message> _messages = [];

  void _enviarMensagem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {

      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            colors: [beigeLight, blueLight, blueMedium, bluePetrol],
            stops: [0.0, 0.35, 0.70, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── AppBar ──────────────────────────────────────
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
                      width: 38,
                      height: 38,
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

              // ── Mensagens ───────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return _buildBubble(msg);
                  },
                ),
              ),

              // ── Input ───────────────────────────────────────
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: beigeLight,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: bluePetrol.withOpacity(0.3), width: 1.5),
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
                      ),
                    ),
                    GestureDetector(
                      onTap: _enviarMensagem,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: bluePetrol,
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
              width: 34,
              height: 34,
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
                color: isIA
                    ? beigeLight.withOpacity(0.88)
                    : bluePetrol.withOpacity(0.85),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isIA ? 4 : 18),
                  bottomRight: Radius.circular(isIA ? 18 : 4),
                ),
                border: isIA
                    ? Border.all(color: bluePetrol.withOpacity(0.15), width: 1)
                    : null,
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  fontSize: 15,
                  color: isIA ? textBlue : beigeLight,
                  height: 1.45,
                ),
              ),
            ),
          ),
          if (!isIA) ...[
            Container(
              width: 34,
              height: 34,
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