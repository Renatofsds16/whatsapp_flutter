import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_flutter/abas/Chamadas.dart';
import 'package:whatsapp_flutter/abas/Contatos.dart';
import 'package:whatsapp_flutter/abas/Conversa.dart';
import 'package:whatsapp_flutter/pages/Login.dart';
import 'package:whatsapp_flutter/rotas/GenerateRoute.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  List<String> opcoes = ['Configuração','Sair'];
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
  _itemSelecionado(String itemEscolhido){
    switch (itemEscolhido){
      case 'Configuração':
        Navigator.pushNamed(context, RouteGenerate.ROTA_CONFIGURACAO);
        break;
      case 'Sair':
        _deslogarUsuario();
        break;
    }
    print(itemEscolhido);
  }
  _deslogarUsuario()async{
    await auth.signOut();


    Navigator.pushReplacementNamed(
        context,
        RouteGenerate.ROTA_LOGIN
    );
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
        actions: [
          PopupMenuButton<String>(
            onSelected: _itemSelecionado,
              itemBuilder: (context){
                return opcoes.map(
                        (String item){
                          return PopupMenuItem<String>(
                            value: item,
                              child: Text(item)
                          );
                        }
                ).toList();
              }
          )
        ],
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
