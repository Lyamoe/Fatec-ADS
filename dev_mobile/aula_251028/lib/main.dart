import 'package:flutter/material.dart';
import 'tela_dados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CamposSimples());
  }
}

class CamposSimples extends StatefulWidget {
  const CamposSimples({super.key});

  @override
  State<CamposSimples> createState() => _CamposSimplesState();
}

/*
o class _CamposSimplesState:  define uma classe de estado, responsável por armazenar e controlar as variáveis e o comportamento dinâmico do widget.
esse underline (_) no começo do nome significa que ela é privada (só pode ser usada dentro do mesmo arquivo Dart).
extends State<CamposSimples>:  indica que essa classe é o estado associado ao widget CamposSimples
Essa linha cria a classe que controla o estado (dados e interações que a gente venha a fazer) do widget CamposSimples.
*/
class _CamposSimplesState extends State<CamposSimples> {
  /*
TextEditingController é uma classe usada para controlar o conteúdo de um campo de texto (TextField ou TextFormField).
Ela serve para Ler o texto digitado pelo usuário, Alterar o texto programaticamente, Limpar o campo, Observar mudanças (com listeners).
*/
  final nome = TextEditingController();
  final email = TextEditingController();

  void enviar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDados(nome: nome.text, email: email.text),
      ),
    );
  }

  /*
CamposSimples é o widget em si.
_CamposSimplesState é o estado, onde você controla o que muda (texto, cores, valores, etc.).
O nome não importa, mas tentamos seguir o que a convenção nos orienta, para ficar fácil de identificar.
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preencher Dados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: enviar, child: const Text('Enviar')),
          ],
        ),
      ),
    );
  }
}

class TelaDados extends StatelessWidget {
  final String nome;
  final String email;

  const TelaDados({super.key, required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados Enviados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $nome', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
