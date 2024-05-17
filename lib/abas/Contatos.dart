import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email;


  Future<List<Usuario>> _recuperarContatos() async {
    List<Usuario> listaUsuario = [];
    QuerySnapshot querySnapshot = await _db.collection('usuarios').get();
    for (DocumentSnapshot item in querySnapshot.docs) {
      String nome = item.get('nome');
      String? url = item.get('url');
      String email = item.get('email');
      if(email == _email) continue;
      Usuario usuario = Usuario();
      usuario.nome = nome;
      usuario.email = email;
      usuario.urlFoto = url;
      listaUsuario.add(usuario);
    }

    return listaUsuario;
  }
  _recuperarEmailUsuario()async{
    User? user = _auth.currentUser;
    if(user != null){
      _email = user.email;
      print('resultato do email $_email');
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarEmailUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recuperarContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Carregando contatos...'),
                    CircularProgressIndicator()
                  ],
                ),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    List<Usuario>? listaUsuario = snapshot.data;
                    if (listaUsuario != null) {
                      Usuario usuario = listaUsuario[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Container(
                          color: Colors.black12,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: ListTile(
                              onTap: (){
                                Navigator.pushNamed(
                                    context,
                                    '/mensagens',
                                  arguments: usuario
                                );
                              },
                              title: Text(usuario.nome),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                backgroundImage: usuario.urlFoto != null
                                    ? NetworkImage(usuario.urlFoto!)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  });
            default:
              return const Center(
                child: Text('voce nao tem contatos'),
              );
          }
        });
  }
}
