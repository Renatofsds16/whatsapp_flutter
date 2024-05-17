import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../Helper/HelpFirebaseAuth.dart';
import '../Helper/HelpFirebaseCloudFirestore.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  File? _imagem;
  String? _urlPefil;
  String? _idUsuarioLogado;
  final TextEditingController _controllerNome = TextEditingController();
  final HelpFirebaseAuth _helpFirebaseAuth = HelpFirebaseAuth();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final HelpFirebaseCloudFirestore _helpFirebaseCloudFirestore = HelpFirebaseCloudFirestore();
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  _recuperarDadosUsuario()async{
    User? user = _helpFirebaseAuth.currentUser();
    if(user != null){
      setState(() {
        _idUsuarioLogado = user.uid;

      });
      DocumentSnapshot documentSnapshot = await _db.collection('usuarios').doc(_idUsuarioLogado).get();
      String nome = documentSnapshot.get('nome');
      String? url = documentSnapshot.get('url');
      if(url != null){
        setState(() {
          _urlPefil = url;
          _controllerNome.text = nome;
        });
      }
    }

  }


  @override
  void initState() {
    _recuperarDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Configuracões',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 120,
                backgroundColor: Colors.grey,
                backgroundImage: _urlPefil != null ? NetworkImage(_urlPefil!): null,

              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              _imagemSelecionada(true);
                            },
                            child: const Text('Camera'),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              _imagemSelecionada(false);
                            },
                            child: const Text('Galeria'),
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                
                child: TextField(
                  controller: _controllerNome,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite seu nome'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {_atualizarNome(_controllerNome.text);},
                    child: const Text('Salvar'),
                  ))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
  _imagemSelecionada(bool isCamera)async{
    XFile? imagemSelecionada;
    ImagePicker imagePicker = ImagePicker();
    if(isCamera){
      imagemSelecionada = await imagePicker.pickImage(source: ImageSource.camera);
      if(imagemSelecionada != null){
        setState(() {
          _imagem = File(imagemSelecionada!.path);
          _uploadImagem();

        });
      }
    }else{
      imagemSelecionada = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imagem = File(imagemSelecionada!.path);
        _uploadImagem();
      });


    }

  }
  Future _uploadImagem()async{
    Reference pastaRaiz = _storage.ref();
    Reference arquivo = pastaRaiz
        .child('perfil')
        .child('$_idUsuarioLogado.jpg');
    if(_imagem != null){
      arquivo.putFile(_imagem!).then((snapshot){
        _recuperarUrlPerfil(snapshot);
      });

    }
  }
  Future _recuperarUrlPerfil(TaskSnapshot taskSnapshot)async{
    String url = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _urlPefil = url;
    });
    if(_idUsuarioLogado != null){
      _savarUlrFireStore(_idUsuarioLogado!,url);
    }

  }
  Future _savarUlrFireStore(String doc,String url)async{
    Map<String,dynamic> map = {'url':url};
    _helpFirebaseCloudFirestore.atualizarDados(doc,map);


  }
  Future _atualizarNome(String nome)async{
    Map<String,dynamic> map = {
      'nome':nome
    };
    if(_idUsuarioLogado != null){
      _db.collection('usuarios')
          .doc(_idUsuarioLogado)
          .update(map);
    }
  }



}
