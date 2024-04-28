import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  final TextEditingController _controllerNomeConfig = TextEditingController();
  String? _urlPerifl;
  Reference storage = FirebaseStorage.instance.ref();
  String? _erroNomeConfig;
  File? _imagem;
  User? _usuarioLogado;

  Future _recuperaImagem(bool recurso) async {
    XFile? imagemSelecionada;
    ImagePicker imagePicker = ImagePicker();
    if (recurso) {
      imagemSelecionada =
          await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      imagemSelecionada =
          await imagePicker.pickImage(source: ImageSource.gallery);
    }

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada!.path);
        if (_imagem != null) {
          _uploadImagem();
        }
      });
    }
  }

  _uploadImagem() async {
    Reference arquivo = storage
        .child('perfil')
        .child('usuario')
        .child('${_usuarioLogado!.uid}.jpg');
    TaskSnapshot taskSnapshot = await arquivo.putFile(_imagem!);
    _recuperarUrlImagePerfil(taskSnapshot);


  }
  _recuperarUrlImagePerfil(TaskSnapshot taskSnapshot)async{
    String url = await taskSnapshot.ref.getDownloadURL();
    _atualizarImagemFirestore(url);
      setState(() {
        _urlPerifl = url;
      });
  }
  _atualizarImagemFirestore(String url){
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> map = {
      'urlImagem':url
    };
    db.collection('usuario').doc(_usuarioLogado?.uid).update(map);
  }
  _atualizarNomeFirestore(){
    String nome = _controllerNomeConfig.text;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String,dynamic> map = {
      'nome': nome
    };
    db.collection('usuario').doc(_usuarioLogado?.uid).update(map);
  }

  Future _recuperarUsuarioLogado() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    _usuarioLogado = auth.currentUser;
    DocumentSnapshot snap = await db.collection('usuario').doc(_usuarioLogado?.uid).get();
    String url = snap.get('urlImagem');

    setState(() {
      _urlPerifl = url;
    });
  }


  @override
  void initState() {
    _recuperarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Confugurações',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: _urlPerifl != null ? NetworkImage(_urlPerifl!): null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                  onPressed: () {
                                    _recuperaImagem(true);
                                  },
                                  child: const Text('Camera')))),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                _recuperaImagem(false);
                              },
                              child: const Text('Galeria'))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _controllerNomeConfig,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          errorText: _erroNomeConfig,
                          border: const OutlineInputBorder(),
                          labelText: 'Digite seu nome'),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Salvar'),
                    ))
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
