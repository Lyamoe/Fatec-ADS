import 'package:flutter/material.dart';
import './cadastro.dart';
import './login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
                          MaterialPageRoute(builder: (context) => Cadastro()),
                        ),
                    child: Text('Cadastro'),
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
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
                    child: Text('Login'),
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
