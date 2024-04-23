import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/pages/Cadastro.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import 'package:whatsapp_flutter/ultius/ultius.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _erroEmail;
  String? _erroSenha;

  Future _verificarUsuarioLogado() async {
    User? usuario = await auth.currentUser;
    //auth.signOut();
    if(usuario != null){
      print(usuario);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }


  _vericarCamposLogin(){
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if(email.isNotEmpty){
      _erroEmail = null;
      if(senha.isNotEmpty){
        setState(() {
          _erroSenha = null;
        });
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);

      }else{
        setState(() {
          _erroSenha = 'Por favor digite sua senha';
        });

      }
    }else{
      setState(() {
        _erroEmail = 'Por favor digite seu Email';
      });

    }
  }
  _logarUsuario(Usuario usuario) async {
    await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).catchError((onError){
      setState(() {
        _erroEmail = 'Credenciais invalida';
      });
    });
    proximaTela(context, const Home());
  }
  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Image.asset(
                  'images/logo.png',
                  width: 200,
                  height: 200,
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    errorText: _erroEmail,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite Seu Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                obscureText: true,
                controller: _controllerSenha,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: _erroSenha,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tem uma conta? '),
                GestureDetector(
                    onTap: () {
                      proximaTela(context, const Cadastro());
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 32, right: 16),
                    child: ElevatedButton(
                        onPressed:_vericarCamposLogin,
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 24),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
