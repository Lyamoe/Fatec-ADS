//? ========================================
//? ------------------- IMPORTS ------------------
//? ========================================

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//? ========================================
//? ------------- CHAMADAS INICIAIS ------------
//? ========================================
void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: WhatsAppHome()),
);

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

final fallbackConversas = [
  {
    'nome': 'Junhan',
    'foto':
        'https://64.media.tumblr.com/e724270bd3781d7ed7a5a29ac5cd3277/eb1a3116754ac1f3-e6/s1280x1920/6c813d3cd40ffd60776732de463bfbde3986f776.jpg',
    'msg': 'Im learning a new song ^^',
    'hora': '19:34',
  },
  {
    'nome': 'Gaon',
    'foto':
        'https://64.media.tumblr.com/a2f7378230505d349aba0c78c27bfe2e/fddc145234c061b5-74/s250x400/760baffe0e5e920804c66a0c95e1f987eebc4ada.pnj',
    'msg': 'Wait wait wait what',
    'hora': '16:12',
  },
  {
    'nome': 'Xdinary Heroes',
    'foto':
        'https://64.media.tumblr.com/6ff599129f8dcdb000be0a3a05bbf9d8/a1c4c784f9631956-81/s1280x1920/1999d16cd7b94d9fcb6b341b3ad68de278f59e0f.jpg',
    'msg': 'Gaon: GUYS JOOYEON BURNED THE KITCHEN',
    'hora': '13:15',
  },
  {
    'nome': 'Gunil',
    'foto':
        'https://64.media.tumblr.com/1794a84e10c7461b83e8c4ad74c0ea64/d3f1bdfc03ea2901-b4/s100x200/cab1fab015b40ca5260926eb98f6e79162b79459.pnj',
    'msg': 'How have you been?',
    'hora': '13:10',
  },
  {
    'nome': 'Jooyeon',
    'foto':
        'https://64.media.tumblr.com/1ea89da81791128899c6b30c2f52f514/11194cec817e0593-b4/s400x600/35b529c91384b3237b2a2f57c5c1c65d00d6ce9b.jpg',
    'msg': 'THEY BANNED YASUO',
    'hora': '12:55',
  },
  {
    'nome': 'O.de',
    'foto':
        'https://64.media.tumblr.com/bf4593057dcbdba0dc38ecc6ad708a32/2b4d9c9155859dd0-fa/s250x400/55fadbb729861c66a0a8185b8a7399092bc98564.pnj',
    'msg': 'Sorry I was at the gym',
    'hora': '09:20',
  },
  {
    'nome': 'Jungsu',
    'foto':
        'https://64.media.tumblr.com/077620648bb7ed7ab67cd7c384e1eae1/ad6633d564a53f6d-ee/s250x400/c6bddbf9cbf329cf5370f6ba865564b692d64025.jpg',
    'msg': '> audio 3:42',
    'hora': '08:47',
  },
];

//? ========================================
//? --------------- ESTADO GERAL ---------------
//? ========================================
class _WhatsAppHomeState extends State<WhatsAppHome> {
  int _indiceAtual = 1; //? 0 = status, 1 = conversas, 2 = configs

  String _nomeUsuario = "Usuário"; //? Guarda o nome que o usuário escolher
  final TextEditingController _nomeController =
      TextEditingController(); //? Permite a alteração do nome

  //? ========== Funções buscar e salvar nome ==========
  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }

  Future<void> _carregarNomeSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeUsuario = prefs.getString('nome_usuario') ?? "Usuário";
      _nomeController.text = _nomeUsuario;
    });
  }

  Future<void> _salvarNome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome_usuario', _nomeController.text);

    setState(() {
      _nomeUsuario = _nomeController.text;
    });

    if (!mounted) {
      return; //? Interrompe caso o widget seja destruido antes do fim da função
    }

    Navigator.pop(context); //? Fecha o Drawer após salvar

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Nome salvo com sucesso!')));
  }

  //? ========== Busca dos dados de conversas ==========
List _carregarFallback() {
    print('>>> Erro na API. Carregando fallback');
    return fallbackConversas;
  }

  Future<List> buscar() async {
    try {
      //? Tenta puxar do banco online
      final url = Uri.parse('https://whatsapp-fatec.great-site.net/api-data.php');
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        try {
          return json.decode(resposta.body);
        } catch (e) {
          //* Caso não seja json
          return _carregarFallback();
        }
      } else {
        //* Caso não tenha puxado corretamente
        return _carregarFallback();
      }
    } catch (e) {
      //* Caso a rede falhe
      return _carregarFallback();
    }
  }

  //? ========================================
  //? --------------- PÁGINA BASE ----------------
  //? ========================================
  @override
  Widget build(BuildContext context) {
    //? ========== Opções de dados para o body ==========
    final List<Widget> telas = [
      _carregaStatus(),
      _carregaConversas(),
      _carregaConfiguracoes(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFF4),
      appBar: AppBar(
        title: Text(
          'WhatsApp Lyam (Karine)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0F846B),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton( //? ícone de pesquisa (não funciona)
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Builder( //? Menu lateral
            builder: (newContext) {
              return IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  Scaffold.of(newContext).openEndDrawer(); //? abre o drawer
                },
              );
            },
          ),
        ],
      ),

      endDrawer: Drawer( //? insere o drawer à direita (fim do appbar)
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xFF0F846B)),
              accountName: Text( //? Exibe os dados de nome inseridos localmente
                _nomeUsuario,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text("Configuração Local"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Altere seu nome:"),
                  TextField( //? input de nome
                    controller: _nomeController,
                    decoration: InputDecoration(hintText: "Digite seu nome"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0F846B),
                    ),
                    onPressed: _salvarNome,
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: telas[_indiceAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        selectedItemColor: const Color(0xFF0F846B),
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.donut_large),
            label: 'Status',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Conversas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }

  //? ========================================
  //? -------------- TELA CONVERSAS --------------
  //? ========================================
  Widget _carregaConversas() {
    return FutureBuilder<List>(
      future: buscar(), //? Pega os dados das conversas
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //* Não encontrou
          return Center(child: Text("Erro ao carregar dados"));
        }
        if (!snapshot.hasData) {
          //* Carregando
          return const Center(child: CircularProgressIndicator());
        }

        final mensagens = snapshot.data!;

        return ListView.separated(
          itemCount: mensagens.length,
          separatorBuilder: (_, _) =>
              Divider(color: const Color.fromARGB(255, 220, 220, 220), thickness: 1),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () { 
                //? ========== abre a conversa ao clicar ==========
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaConversa(
                      nome: mensagens[index]['nome'],
                      foto: mensagens[index]['foto'],
                      msg: mensagens[index]['msg'],
                    ),
                  ),
                );
              },
              //? ========== Define os dados da conversa ==========
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(mensagens[index]['foto']),
              ),
              title: Text(
                mensagens[index]['nome'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mensagens[index]['msg'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF626262)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mensagens[index]['hora'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF01CD40),
                    ),
                  ),
                  SizedBox(height: 5),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xFF01CD40),
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
    );
  }

  //? ========================================
  //TODO: ---------------- TELA STATUS ---------------
  //? ========================================
  Widget _carregaStatus() {
    return FutureBuilder<List>(
      future: buscar(), //? Pega os dados das conversas
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //* Não encontrou
          return Center(child: Text("Erro ao carregar dados"));
        }
        if (!snapshot.hasData) {
          //* Carregando
          return const Center(child: CircularProgressIndicator());
        }

        final mensagens = snapshot.data!;

        return ListView.separated(
          itemCount: mensagens.length,
          separatorBuilder: (_, _) =>
              Divider(color: const Color.fromARGB(255, 220, 220, 220), thickness: 1),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () { 
                //? ========== abre a conversa ao clicar ==========
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaConversa(
                      nome: mensagens[index]['nome'],
                      foto: mensagens[index]['foto'],
                      msg: mensagens[index]['msg'],
                    ),
                  ),
                );
              },
              //? ========== Define os dados da conversa ==========
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(mensagens[index]['foto']),
              ),
              title: Text(
                mensagens[index]['nome'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mensagens[index]['msg'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF626262)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mensagens[index]['hora'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF01CD40),
                    ),
                  ),
                  SizedBox(height: 5),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xFF01CD40),
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
    );
  }

  //? ========================================
  //TODO: --------------- TELA CONFIGS ---------------
  //? ========================================
  Widget _carregaConfiguracoes() {
    return FutureBuilder<List>(
      future: buscar(), //? Pega os dados das conversas
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //* Não encontrou
          return Center(child: Text("Erro ao carregar dados"));
        }
        if (!snapshot.hasData) {
          //* Carregando
          return const Center(child: CircularProgressIndicator());
        }

        final mensagens = snapshot.data!;

        return ListView.separated(
          itemCount: mensagens.length,
          separatorBuilder: (_, _) =>
              Divider(color: const Color.fromARGB(255, 220, 220, 220), thickness: 1),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () { 
                //? ========== abre a conversa ao clicar ==========
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaConversa(
                      nome: mensagens[index]['nome'],
                      foto: mensagens[index]['foto'],
                      msg: mensagens[index]['msg'],
                    ),
                  ),
                );
              },
              //? ========== Define os dados da conversa ==========
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(mensagens[index]['foto']),
              ),
              title: Text(
                mensagens[index]['nome'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mensagens[index]['msg'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF626262)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mensagens[index]['hora'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF01CD40),
                    ),
                  ),
                  SizedBox(height: 5),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xFF01CD40),
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
    );
  }
}

  //? ========================================
  //? ------------- PÁGINA CONVERSA --------------
  //? ========================================
class TelaConversa extends StatelessWidget {
  final String nome;
  final String foto;
  final String msg;

  //? ========== Puxa os dados da conversa clicada ==========
  const TelaConversa({super.key, required this.nome, required this.foto, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F846B),
        leadingWidth: 20,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(foto), radius: 18),
            SizedBox(width: 10),
            Text(nome, style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE5DDD5),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        msg,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //? ========== Input para enviar uma mensagem ==========
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Mensagem",
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),

                  //? ========== Botão de enviar (que começa como botão de áudio) ==========
                  CircleAvatar(
                    backgroundColor: Color(0xFF0F846B),
                    radius: 22,
                    child: Icon(Icons.mic, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
