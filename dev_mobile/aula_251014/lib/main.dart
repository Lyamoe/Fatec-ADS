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
          title: Text("I'll kill myself"),
          actions: [Icon(Icons.more_horiz)],
        ),
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text('i hate u ${index + 1}'));
          },
        ),

        // aaaaaaaaaa // bbbbbbbbb // ccccccc

        // body: ListView(
        //   children: [
        //     Card(
        //       child: ListTile(
        //         leading: Icon(Icons.lock_outline, color: Colors.yellow),
        //         title: Text("Conteúdo principal"),
        //         trailing: Icon(Icons.more_vert),
        //       ),
        //     ),
        //     ListTile(
        //       leading: Checkbox(value: true, onChanged: (bool? value) {}),
        //       title: Text("Conteúdo principal"),
        //       subtitle: Text('Subtitulo yay'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
