import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/pages/Cadastro.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import 'package:whatsapp_flutter/pages/Login.dart';
import 'package:whatsapp_flutter/pages/configuracao.dart';

class RouteGenerate {
  static const String ROTA_HOME = '/home';
  static const String ROTA_LOGIN_BARRA = '/';
  static const String ROTA_LOGIN = '/login';
  static const String ROTA_CADASTRO = '/cadastro';
  static const String ROTA_CONFIGURACAO = '/configuracao';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case ROTA_LOGIN_BARRA:
        return MaterialPageRoute(builder: (context) => const Login());
      case ROTA_LOGIN:
        return MaterialPageRoute(builder: (context) => const Login());
      case ROTA_CADASTRO:
        return MaterialPageRoute(builder: (context) => const Cadastro());
      case ROTA_HOME:
        return MaterialPageRoute(builder: (context) => const Home());
      case ROTA_CONFIGURACAO:
        return MaterialPageRoute(builder: (context) => const Configuracao());
      default:
        return MaterialPageRoute(builder: (context) => const Login());
    }

  }

}