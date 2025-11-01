import 'package:flutter/material.dart';

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

class _CamposSimplesState extends State<CamposSimples> {
  final textoValor = TextEditingController();
  final numeroValor = TextEditingController();
  String? dropdownValor = "";
  int? radioValor = 0;
  bool switchValor = false;

  void enviar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        // TODO: ALTERAR CAMPOS ENVIADOS PARA TELADADOS
        builder:
            (context) => TelaDados(
              textoValor: textoValor.text,
              numeroValor: numeroValor.text,
              dropdownValor: dropdownValor.toString(),
              radioValor: radioValor!,
              switchValor: switchValor,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preencher Dados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ? INPUT N1
            TextField(
              controller: textoValor,
              decoration: const InputDecoration(labelText: 'Texto'),
            ),

            // ? INPUT N2
            TextFormField(
              controller: numeroValor,
              decoration: InputDecoration(labelText: "Número"),
              keyboardType: TextInputType.number,
            ),

            // ? INPUT N3
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Dropdown"),
              value: dropdownValor,
              items: [
                DropdownMenuItem(value: "", child: Text("Selecione uma opção")),
                DropdownMenuItem(value: "Opção A", child: Text("Opção A")),
                DropdownMenuItem(value: "Opção B", child: Text("Opção B")),
              ],
              onChanged: (v) => setState(() => dropdownValor = v),
            ),

            // ? INPUT N4
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Radio:"),
                RadioListTile<int>(
                  title: Text("Opção 1"),
                  value: 1,
                  groupValue: radioValor,
                  onChanged: (v) => setState(() => radioValor = v),
                ),
                RadioListTile<int>(
                  title: Text("Opção 2"),
                  value: 2,
                  groupValue: radioValor,
                  onChanged: (v) => setState(() => radioValor = v),
                ),
              ],
            ),

            // ? INPUT N4
            SwitchListTile(
              title: Text("Switch"),
              value: switchValor,
              onChanged: (v) => setState(() => switchValor = v),
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
  final String textoValor;
  final String numeroValor;
  final String dropdownValor;
  final int radioValor;
  final bool switchValor;

  const TelaDados({
    super.key,
    required this.textoValor,
    required this.numeroValor,
    required this.dropdownValor,
    required this.radioValor,
    required this.switchValor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados Enviados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Texto: $textoValor', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Numero: $numeroValor', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              'Dropdown: $dropdownValor',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text('Radio: $radioValor', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Switch: $switchValor', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
