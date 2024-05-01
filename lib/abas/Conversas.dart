import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/Conversas.dart';
import '../Helper/HelpFirebaseCloudFirestore.dart';

class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {
  final HelpFirebaseCloudFirestore _helpFirebaseCloudFirestore = HelpFirebaseCloudFirestore();
  List<ConversasModel> lista = [
    ConversasModel('Renato', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('taty', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('Renan', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('Rian', 'djksdjfksjfd', 'dfhewfwefhw'),
    ConversasModel('julia', 'djksdjfksjfd', 'dfhewfwefhw'),
  ];
  @override
  void initState() {
    recuperarDados();
    super.initState();
  }
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
  Future recuperarDados()async {
    QuerySnapshot querySnapshot = await _helpFirebaseCloudFirestore.recuperarDadosUsuarios();
    for(DocumentSnapshot item in querySnapshot.docs){

    }
  }
}
