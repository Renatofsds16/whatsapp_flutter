import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/Contatos.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  String? emailUsuariologado;
/*  List<Contato> listaContatos = [
    //dados para teste
    Contato('Jose Renato','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7083abde-509a-4184-a808-9418cfa37a40'),
    Contato('Taty','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7083abde-509a-4184-a808-9418cfa37a40'),
    Contato('Nice','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=d23d2f01-ab8d-44f2-91f3-91fce476a140'),
    Contato('Ricardo','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=0f2b7335-5d13-450b-a363-11e812eb7d07'),
    Contato('Leo','https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=68da9248-5126-43a4-8aca-2d8852cbfd37'),
  ];*/
  Future<List<Usuario>>_recuperarContatos()async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('usuario').get();
    List<Usuario> listaUsuario = [];
    for(DocumentSnapshot item in querySnapshot.docs){
      var nome = item.get('nome');
      var url = item.get('urlImagem');
      Usuario usuario = Usuario();
      usuario.nome = nome;
      usuario.urlImagem = url;
      listaUsuario.add(usuario);
    }
    return listaUsuario;



  }
  @override
  void initState() {
    _recuperarContatos();
    _recuperaDadosUsuario();
    super.initState();
  }
  _recuperaDadosUsuario(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if(user != null){
      emailUsuariologado = user.email;
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(future: _recuperarContatos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Usuario>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: Column(
                children: [
                  Text('Carregando contatos'),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data?.length,

                itemBuilder: (context,index){
                List<Usuario>? listaUsuario = snapshot.data;
                Usuario? usuario = listaUsuario?[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: usuario?.urlImagem != null ? NetworkImage(usuario!.urlImagem): null,
                    ),
                    title: Text(usuario!.nome),
                  );
                }
            );
            break;
        }
      },


    );
  }
}
