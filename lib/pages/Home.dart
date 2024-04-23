import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email = '';

  Future dados()async{
    User? usuario = await auth.currentUser;
    if(usuario != null){
      var emailUsuarioLogado = usuario.email;
      if(emailUsuarioLogado != null){
        setState(() {
          _email = emailUsuarioLogado;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whatsapp',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
            _email
        ),
      ),
    );
  }
}
