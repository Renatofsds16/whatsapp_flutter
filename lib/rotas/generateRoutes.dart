import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/pages/Cadastro.dart';
import 'package:whatsapp_flutter/pages/Configuracoes.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import 'package:whatsapp_flutter/pages/Login.dart';

class GenerateRoutes{

  static Route<dynamic> generateRoutes(RouteSettings settings){
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
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login()
        );
    }
  }
}
