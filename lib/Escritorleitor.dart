import 'package:flutter/material.dart';
import 'package:lester/Editardados.dart';
import 'package:lester/perfil.dart';


enum TipoUsuario { leitor, escritor }

class Escritorleitor extends StatefulWidget {
  const Escritorleitor({super.key});

  @override
  State<Escritorleitor> createState() => _EscritorleitorState();
}

class _EscritorleitorState extends State<Escritorleitor> {
  static const Color bluePetrol = Color(0xFF4A7C99);
  static const Color textBlue = Color(0xFF5B8FA3);
  static const Color bgBeige = Color(0xFFF5F3E7);
  static const Color blueLight = Color(0xFFA3CEE8);

  TipoUsuario? _selecionado;

  Widget _buildOpcao({
    required String titulo,
    required IconData icone,
    required TipoUsuario tipo,
  }) {
    final bool selecionado = _selecionado == tipo;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selecionado = tipo;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selecionado ? blueLight.withOpacity(0.3) : bgBeige,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selecionado ? bluePetrol : blueLight,
            width: selecionado ? 2.5 : 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Icon(
              icone,
              size: 28,
              color: selecionado ? bluePetrol : textBlue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  color: selecionado ? bluePetrol : textBlue,
                  fontWeight: selecionado ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              selecionado
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selecionado ? bluePetrol : blueLight,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      body: SafeArea(
        child: Column(
          children: [

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
                        'Mudar para Escritor/leitor',
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

                    _buildOpcao(
                      titulo: 'Leitor',
                      icone: Icons.menu_book_outlined,
                      tipo: TipoUsuario.leitor,
                    ),

                    const SizedBox(height: 16),

                    _buildOpcao(
                      titulo: 'Escritor',
                      icone: Icons.edit_outlined,
                      tipo: TipoUsuario.escritor,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selecionado == null
                      ? null
                      : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Editardados(),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluePetrol,
                    disabledBackgroundColor: bluePetrol.withOpacity(0.4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
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
            ),
          ],
        ),
      ),
    );
  }
}