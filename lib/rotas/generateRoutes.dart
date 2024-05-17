import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:whatsapp_flutter/pages/Cadastro.dart';
import 'package:whatsapp_flutter/pages/Configuracoes.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import 'package:whatsapp_flutter/pages/Login.dart';
import 'package:whatsapp_flutter/pages/mensagens.dart';

class GenerateRoutes{
  static Usuario? usuario;
  static Route<dynamic> generateRoutes(RouteSettings settings){
    final args = settings.arguments;
    usuario = args as Usuario?;
    switch (settings.name){
      case '/':
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login()
        );
      case '/login':
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login()
        );
      case '/cadastro':
      return MaterialPageRoute(
          builder: (BuildContext context) => const Cadastro()
      );
      case '/home':
        return MaterialPageRoute(
            builder: (BuildContext context) => const Home()
        );
      case '/configuracoes':
        return MaterialPageRoute(
            builder: (BuildContext context) => const Configuracoes()
        );
      case '/mensagens':
        return MaterialPageRoute(
            builder: (BuildContext context) => Mensagens(contato: args)
        );
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login()
        );
    }
  }
}
