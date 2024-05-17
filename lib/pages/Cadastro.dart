import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:whatsapp_flutter/pages/Home.dart';

import '../Helper/HelpFirebaseAuth.dart';
import '../Helper/HelpFirebaseCloudFirestore.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final HelpFirebaseAuth _helpFirebaseAuth = HelpFirebaseAuth();
  HelpFirebaseCloudFirestore _helpFirebaseCloudFirestore = HelpFirebaseCloudFirestore();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  String _menssagem = '';
  String? _errorName;
  String? _errorEmail;
  String? _errorSenha;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Faça seu cadastro",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'images/logo.png',
                  width: 200,
                  height: 180,
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerNome,
                decoration: InputDecoration(
                    errorText: _errorName,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu nome'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                    errorText: _errorEmail,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerSenha,
                decoration: InputDecoration(
                    errorText: _errorSenha,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _validarCampos,
                    child: const Text('Salvar'),
                  ),
                ),
                Text(_menssagem),
              ]),
            )
          ],
        ),
      ),
    );
  }

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if (nome.isNotEmpty && nome.length >= 5) {
      _errorName = null;
      if (email.isNotEmpty) {
        if (email.endsWith('@gmail.com')) {
          _errorEmail = null;
          if (senha.isNotEmpty) {
            setState(() {
              _errorSenha = null;
            });
            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.email = email;
            usuario.senha = senha;

            _cadastrarUsuario(usuario);
          } else {
            setState(() {
              _errorSenha = 'Este campo nao pode ficar em vazio';
            });
          }
        } else {
          setState(() {
            _errorEmail = 'Email precisa terminar com "@gmail.com"!';
          });
        }
      } else {
        setState(() {
          _errorEmail = 'Email invalido!';
        });
      }
    } else {
      setState(() {
        _errorName = 'Esse compo precisa conter pelo menos 6 caracteres';
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) async {
    if(usuario.email != null){
      UserCredential? user = await _helpFirebaseAuth
          .createUserWithEmailAndPassword(usuario.email!, usuario.senha);
      if (user?.user != null) {
        //salvar dados usuario
        String? id = user?.user?.uid;
        salvarUsuario(id,usuario.toMap());
        Navigator.pushNamedAndRemoveUntil(context, '/home',(_)=>false);
      } else {
        setState(() {
          _menssagem = 'Não foi possivel cadastra usuario';
        });
      }
    }

  }
  salvarUsuario(String? doc,Map<String,dynamic> map){
    if(doc != null){
      _helpFirebaseCloudFirestore.saveDataUser(doc, map);
    }
  }
}
