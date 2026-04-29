import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController _nomeController = TextEditingController();
  bool _visivel = false;
  double _posicaoY = 30.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _visivel = true;
          _posicaoY = 0;
        });
      }
    });
  }

  void _iniciarQuiz() async {
    String nome = _nomeController.text.trim();

    if (nome.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nome_usuario', nome);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const QuizScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, digite seu nome!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 151, 255),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: AnimatedOpacity(
            opacity: _visivel ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, _posicaoY, 0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/imagens/icone.png',
                    width: 200,
                    height: 200,
                  ),
                  const Text(
                    "JUSTIN BIEBER QUIZ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 111, 33, 129),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: "Qual seu nome, Belieber?",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _iniciarQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          105,
                          20,
                          123,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("ENTRAR"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
