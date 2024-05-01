import 'package:flutter/material.dart';

import '../model/Conversas.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  List<ConversasModel> lista = [
    ConversasModel('Renato', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('taty', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('Renan', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('Rian', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('julia', 'djksdjfksjfd', 'dfhewfwefhw'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context,index){
          ConversasModel conversasModel = lista[index];
          return ListTile(
            title: Text(conversasModel.nomeUsuario),
            subtitle: Text(conversasModel.menssagem),
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
            ),
          );
        }
    );
  }
}
