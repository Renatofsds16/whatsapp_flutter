import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/model/Mensagem.dart';
import 'package:whatsapp_flutter/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mensagens extends StatefulWidget {
  Usuario? contato;

  Mensagens({super.key, required this.contato});

  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _id = '';
  String _url = '';
  final List<String> _listaMensagem = ['renato','taty','nici','rian gabriel e meu amooo','elia tambem'];
  final TextEditingController _controllerEnviarMensagem = TextEditingController();
  _enviarMensagem() {
    String textoMensagem = _controllerEnviarMensagem.text;
    if(textoMensagem.isNotEmpty){
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = textoMensagem;
      mensagem.mensagem = _id;
      mensagem.urlImagem = '';
      mensagem.tipo = 'Texto';
      _salvarMensagem();

    }
  }
  _recuperaUsuarioLogado(){
    if(firebaseAuth.currentUser?.uid != null){
      _id = firebaseAuth.currentUser!.uid;
    }
  }
  _salvarMensagem(){
    // parei aqui para recomeça
  }
  _enviarFoto() {}
  String? _recuperaUrlFoto(){
    String? urlFoto = '';
    if(widget.contato?.urlFoto != null){
      urlFoto = widget.contato?.urlFoto;
      return urlFoto;
    }else{
      urlFoto = '';
      return urlFoto;
    }
  }
  @override
  void initState() {
    _url = _recuperaUrlFoto()!;
    _recuperaUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var caixaMensagem = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controllerEnviarMensagem,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32)
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.camera_alt,color: Colors.green,),
                onPressed: _enviarFoto,
              )
            ),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0,0, 0),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _enviarMensagem,
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
    var listaMensagem = Expanded(
        child: ListView.builder(
          itemCount: _listaMensagem.length,
            itemBuilder: (context,indice){
            double larguraContainer = MediaQuery.of(context).size.width * 0.8;
              Alignment aliamento = Alignment.bottomRight;
              Color color = const Color(0xffd2ffa5);
              if(indice % 2 == 0){
                aliamento = Alignment.bottomLeft;
                color = Colors.white;
              }

              return Align(
                alignment: aliamento,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: larguraContainer,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(Radius.circular(16))

                    ),
                    child: Text(_listaMensagem[indice],style: const TextStyle(fontSize: 20
                    ),),
                  ),
                ),
              );
            }
        )

    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 24,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato?.urlFoto != null ? NetworkImage(widget.contato!.urlFoto!):null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                widget.contato!.nome,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.cover)),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                listaMensagem,
                caixaMensagem,
                //listView
                //caixa de menssagem
              ],
            ),
          ),
        ),
      ),
    );
  }
}
