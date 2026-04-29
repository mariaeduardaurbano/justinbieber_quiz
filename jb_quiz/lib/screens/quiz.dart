import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'resultado.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List _perguntas = [];
  int _perguntaAtual = 0;
  int _pontuacao = 0;
  int? _respostaSelecionada;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarPerguntas();
  }

  Future<void> _carregarPerguntas() async {
    try {
      final String response =
          await rootBundle.loadString('assets/mockup/perguntas.json');
      final data = await json.decode(response);
      setState(() {
        _perguntas = data;
        _carregando = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar JSON: $e");
    }
  }

  void _responder() {
    if (_respostaSelecionada == (_perguntas[_perguntaAtual]['correta'] - 1)) {
      _pontuacao++;
    }

    if (_perguntaAtual < _perguntas.length - 1) {
      setState(() {
        _perguntaAtual++;
        _respostaSelecionada = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultadoScreen(acertos: _pontuacao, total: _perguntas.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final perguntaData = _perguntas[_perguntaAtual];
    final List opcoes = perguntaData['respostas'] ?? [];
    final String caminhoImagem = perguntaData['ilustracao'] ?? "";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 186, 240),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 112, 34, 128),
          title: const Text("Justin Bieber Quiz",
              style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Questão ${_perguntaAtual + 1} de ${_perguntas.length}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Image.asset(caminhoImagem,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Icon(Icons.image)),
            const SizedBox(height: 20),
            Text(perguntaData['pergunta'] ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: opcoes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: RadioListTile<int>(
                      title: Text(opcoes[index].toString()),
                      value: index,
                      groupValue: _respostaSelecionada,
                      onChanged: (v) =>
                          setState(() => _respostaSelecionada = v),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _respostaSelecionada == null ? null : _responder,
              child: const Text("PRÓXIMA"),
            ),
          ],
        ),
      ),
    );
  }
}