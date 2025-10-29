import 'package:flutter/material.dart';
import './main.dart';
import './cadastro.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Demo'),
          actions: <Widget>[
            Builder(
              builder: (BuildContext innerContext) {
                return Center(
                  child: ElevatedButton(
                    onPressed:
                        () => Navigator.push(
                          innerContext,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        ),
                    child: Text('Home'),
                  ),
                );
              },
            ),
            Builder(
              builder: (BuildContext innerContext) {
                return Center(
                  child: ElevatedButton(
                    onPressed:
                        () => Navigator.push(
                          innerContext,
                          MaterialPageRoute(builder: (context) => Cadastro()),
                        ),
                    child: Text('Cadastro'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
