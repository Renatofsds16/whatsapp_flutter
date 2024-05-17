import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/abas/Chamadas.dart';
import 'package:whatsapp_flutter/abas/Contatos.dart';
import 'package:whatsapp_flutter/abas/Conversas.dart';
import 'package:whatsapp_flutter/pages/Configuracoes.dart';
import 'package:whatsapp_flutter/pages/Login.dart';

import '../Helper/HelpFirebaseAuth.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  HelpFirebaseAuth _helpFirebaseAuth = HelpFirebaseAuth();
  List<String> opcoes = [
    'Configuracoes',
    'Sair',
  ];
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _verificarUsuarioLogado();
    recuperarDadosUsuario();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Whatsapp',style: TextStyle(color: Colors.white),),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          labelColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 16),
          tabs: const [
          Tab(
            text: 'Conversas',
            icon: Icon(Icons.message),
          ),
          Tab(
            text: 'Contatos',
            icon: Icon(Icons.perm_contact_cal_rounded),
          ),
            Tab(
              text: 'Chamadas',
              icon: Icon(Icons.call),
            ),
        ],

        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            onSelected: escolhaUsuario,
              itemBuilder: (context){
                return opcoes.map(
                        (String item){
                          return PopupMenuItem(

                            value: item,
                              child: Text(item)
                          );
                        }
                ).toList();
              }
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Conversas(),
          Contatos(),
          Chamadas()
        ],
      ),
    );
  }
  recuperarDadosUsuario(){

  }
  escolhaUsuario(String escolha){
    if(escolha == opcoes[0]){
      Navigator.pushNamed(context, '/configuracoes');

    }
    if(escolha == opcoes[1]){
      _helpFirebaseAuth.exitUser();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  _verificarUsuarioLogado() async {
    User? user = await _helpFirebaseAuth.currentUser();
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
