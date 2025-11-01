import 'package:flutter/material.dart';
import './main.dart';
import './login.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

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
