import 'package:flutter/material.dart';
import 'package:lester/perfil.dart';
import 'package:lester/escritorleitor.dart';
import 'package:lester/login.dart';

class Editardados extends StatefulWidget {
  const Editardados({super.key});

  @override
  State<Editardados> createState() => _EditardadosState();
}

class _EditardadosState extends State<Editardados> {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _gmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
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
                        'Editar Dados',
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
                  children: [
                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: bgBeige,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: blueLight,
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          labelStyle: TextStyle(
                            color: textBlue,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: textBlue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: bgBeige,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: blueLight,
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _gmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Alterar Gmail',
                          labelStyle: TextStyle(
                            color: textBlue,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: textBlue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4E8EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE89A7D),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bluePetrol,
                                    width: 3,
                                  ),
                                ),
                                child: Center(
                                  child: CustomPaint(
                                    size: const Size(75, 75),
                                    painter: AvatarPainter(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: blueLight,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Escritorleitor(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: blueLight,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Trocar para leitor/escritor',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const login(),
                          ),
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: bluePetrol,
                          width: 2,
                        ),
                        backgroundColor: bgBeige,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'Sair da Conta',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: bluePetrol,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Perfil(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bluePetrol,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Concluir',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
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
    );
  }
}

class AvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.15,
      paint,
    );

    final bodyPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.5,
        size.width * 0.75,
        size.height * 0.75,
      )
      ..close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}