import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash.dart';

class ResultadoScreen extends StatefulWidget {
  final int acertos;
  final int total;

  const ResultadoScreen(
      {super.key, required this.acertos, required this.total});

  @override
  State<ResultadoScreen> createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  String _nome = "Belieber";

  @override
  void initState() {
    super.initState();
    _recuperarNome();
  }

  void _recuperarNome() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome_usuario') ?? "Belieber";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 137, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 118, 30, 134),
        title: const Text("Resultado", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Parabéns, $_nome!",
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Você acertou ${widget.acertos} de ${widget.total}"),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 133, 47, 146),
                  foregroundColor: Colors.white,
                ),
                child: const Text("RECOMEÇAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}