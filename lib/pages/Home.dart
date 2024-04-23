import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_flutter/abas/Chamadas.dart';
import 'package:whatsapp_flutter/abas/Contatos.dart';
import 'package:whatsapp_flutter/abas/Conversa.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  FirebaseAuth auth = FirebaseAuth.instance;
  TabController? _tabController;
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
  void initState() {
    super.initState();
    dados();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whatsapp',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        bottom: TabBar(
          unselectedLabelColor: Colors.white60,
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,


          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Conversas',),
            Tab(text: 'Contatos',),
            Tab(text: 'Chamadas',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Conversas(),
          Contatos(),
          Chamadas()
        ],
      )
    );
  }
}
