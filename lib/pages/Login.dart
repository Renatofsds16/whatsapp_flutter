import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:whatsapp_flutter/pages/Cadastro.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import '../Helper/HelpFirebaseAuth.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final HelpFirebaseAuth _helpFirebaseAuth = HelpFirebaseAuth();
  final TextEditingController _controllerEmailLogin = TextEditingController();
  final TextEditingController _controllerSenhaLogin = TextEditingController();
  String? _errorEmail;
  String? _errorSenha;

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
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
                controller: _controllerEmailLogin,
                decoration: InputDecoration(
                    errorText: _errorEmail,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                obscureText: true,
                controller: _controllerSenhaLogin,
                decoration: InputDecoration(

                    errorText: _errorSenha,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tem conta? '),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cadastro()));
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _validarCampos,
                    child: const Text('Login'),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  _validarCampos() {
    String email = _controllerEmailLogin.text;
    String senha = _controllerSenhaLogin.text;
    if (email.isNotEmpty) {
      if (email.endsWith('@gmail.com')) {
        _errorEmail = null;
        if (senha.isNotEmpty) {
          //loga usuario
          Usuario usuario = Usuario();
          usuario.email = email;
          usuario.senha = senha;
          _loginUser(usuario);
        } else {
          setState(() {
            _errorSenha =
                'Senha invalida! sua senha tem pelos menos 6 caractere.';
          });
        }
      } else {
        setState(() {
          _errorEmail = 'Email invalido digite "exemple@gmail,com"';
        });
      }
    } else {
      setState(() {
        _errorEmail = 'Esse campo nao pode ficar vazio';
      });
    }
  }

  _loginUser(Usuario usuario) async {
    UserCredential user = await _helpFirebaseAuth
        .loginUser(usuario.email, usuario.senha)
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, '/home');
      return firebaseUser;
    }).catchError((error){
      setState(() {
        _errorEmail = 'credenciais invalidas';
      });
    });

  }

  _verificarUsuarioLogado() async {
    User? user = await _helpFirebaseAuth.currentUser();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
