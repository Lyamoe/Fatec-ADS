import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); //? MyApp é o nome padrão da tela inicial
  //? runApp executa a classe. a const é porque a classe não muda
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); //? parametro padrão

  @override
  Widget build(BuildContext context) {
    // ? Pode retornar MaterialApp ou CupertinoApp
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "hiii",
            style: TextStyle(
              fontSize: 50.0,
              color: Color.fromRGBO(15, 2, 46, 1),
            ),
          ),
        ),
      ),
    );
  }
}
