import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  TextEditingController _controllerNomeConfig = TextEditingController();
  String? _erroNomeConfig;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Confugurações',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7083abde-509a-4184-a808-9418cfa37a40'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Camera')))),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Galeria'))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _controllerNomeConfig,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          errorText: _erroNomeConfig,
                          border: const OutlineInputBorder(),
                          labelText: 'Digite seu nome'),
                    ),
                  ),
                  ElevatedButton(onPressed: (){}, child: const Text('Salvar'))

                ],
              ),
            ),
          ),
        ));
  }
}
