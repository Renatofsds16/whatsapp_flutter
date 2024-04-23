import 'package:flutter/material.dart';

import '../model/Contatos.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  List<Contato> listaContatos = [
    Contato('Jose Renato','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7083abde-509a-4184-a808-9418cfa37a40'),
    Contato('Taty','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7083abde-509a-4184-a808-9418cfa37a40'),
    Contato('Nice','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=d23d2f01-ab8d-44f2-91f3-91fce476a140'),
    Contato('Ricardo','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=0f2b7335-5d13-450b-a363-11e812eb7d07'),
    Contato('Leo','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=68da9248-5126-43a4-8aca-2d8852cbfd37'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaContatos.length,
        itemBuilder: (context, index) {
          var conversa = listaContatos[index];
          return ListTile(
            trailing: Text('data aqui'),
            contentPadding:
            const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            leading: CircleAvatar(
              maxRadius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(conversa.caminhoFoto),
            ),
            title: Text(
              conversa.nome,
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            ),
          );
        });
  }
}
