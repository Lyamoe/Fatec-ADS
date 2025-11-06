import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WhatsApp()));

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  Future<List> buscar() async {
    final resposta = await http.get(
      Uri.parse('https://etecsaosebastiao.com.br/json/listview.json'),
    );
    return json.decode(resposta.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFF4),
      appBar: AppBar(
        title: Text(
          'Lyam (Karine) 4 ADS',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0F846B),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chats',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      CircleAvatar(
                        radius: 10, // circle size
                        backgroundColor: Colors.white,
                        child: Text(
                          '7',
                          style: TextStyle(
                            color: const Color(0xFF0F846B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Calls',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

      body: FutureBuilder<List>(
        future: buscar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notSeen = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: notSeen.length,
            separatorBuilder: (_, __) =>
                Divider(color: const Color(0xFFF0F0F0), thickness: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(notSeen[index]['foto']),
                ),
                title: Text(
                  notSeen[index]['nome'],
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  notSeen[index]['msg'],
                  style: const TextStyle(color: Color(0xFF626262)),
                ),
                trailing: Column(
                  children: [
                    Text(
                      notSeen[index]['hora'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF01CD40),
                      ),
                    ),
                    CircleAvatar(
                      radius: 10, // circle size
                      backgroundColor: const Color(0xFF01CD40),
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
