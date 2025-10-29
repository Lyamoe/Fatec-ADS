import 'package:flutter/material.dart';

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