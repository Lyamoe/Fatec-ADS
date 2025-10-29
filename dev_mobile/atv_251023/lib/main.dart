import 'package:flutter/material.dart';

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
          title: Text("Yayyy inputs"),
          actions: [Icon(Icons.more_horiz)],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  hintText: 'Karine (Lyam) Santos Peres',
                  prefix: Text(":"),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: '4 ADS',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Turma',
                ),
                onChanged: (String? aaaaaaa) {},
                items: [
                  DropdownMenuItem(value: '4 ADS', child: Text('4 ADS')),
                  DropdownMenuItem(value: '3 ADS', child: Text('3 ADS')),
                  DropdownMenuItem(value: '2 ADS', child: Text('2 ADS')),
                  DropdownMenuItem(value: '1 ADS', child: Text('1 ADS')),
                ],
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Stan Loona'),
                value: true,
                onChanged: (bool? bbbbbb) {},
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('É dia'),
                subtitle: const Text('Bom dia'),
                value: true,
                onChanged: (bool ddddd) {},
                secondary: const Icon(Icons.sunny),
              ),
              const SizedBox(height: 16),
              Slider(
                value: 3.0, // Use sua variável de estado aqui
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (eeeeee) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
