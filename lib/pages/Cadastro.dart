import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:whatsapp_flutter/pages/Home.dart';
import 'package:whatsapp_flutter/rotas/GenerateRoute.dart';
import 'package:whatsapp_flutter/ultius/ultius.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerEmailCadastro = TextEditingController();
  TextEditingController _controllerSenhaCadastro = TextEditingController();
  TextEditingController _controllerNomeCadastro = TextEditingController();
  String? _erroNomeCadastro;
  String? _erroEmailCadastro;
  String? _erroSenhaCadastro;

  bool _validarCampos(){
    String nome = _controllerNomeCadastro.text;
    String email = _controllerEmailCadastro.text;
    String senha = _controllerSenhaCadastro.text;
    if(nome.isNotEmpty){
      _erroNomeCadastro = null;
      if(email.isNotEmpty){
        _erroEmailCadastro = null;
        if(senha.isNotEmpty){
          setState(() {
            _erroSenhaCadastro = null;
          });
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          _cadastraUsuario(usuario);
          return true;
        }else{
          setState(() {
            _erroSenhaCadastro = 'Por favor digite seu Email';
          });
          return false;
        }
      }else{
        setState(() {
          _erroEmailCadastro = 'Por favor digite seu Email';
        });
        return false;
      }
    }else{
      setState(() {
        _erroNomeCadastro = 'Por favor digite seu nome';
      });
      return false;
    }
  }

  _cadastraUsuario(Usuario usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then(
            (firebaseAuth ){
              FirebaseFirestore db = FirebaseFirestore.instance;
              db.collection('usuario')
                  .doc(firebaseAuth.user?.uid)
                  .set(usuario.toMap());
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteGenerate.ROTA_HOME,
                  (context) => false)
              ;
              //Navigator.pushReplacementNamed(context, RouteGenerate.ROTA_HOME);

            }
    ).catchError(
            (erro){
              print(erro);
            }
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Cadastre-se',
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
                controller: _controllerNomeCadastro,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: _erroNomeCadastro,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu nome'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerEmailCadastro,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: _erroEmailCadastro,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite Seu Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerSenhaCadastro,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _erroSenhaCadastro,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: (){
                          // salva usuario aqui
                          if(_validarCampos()){
                            proximaTela(context, const Home());
                          }
                        }, child: const Text('Cadastrar',style: TextStyle(fontSize: 24),)),
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
