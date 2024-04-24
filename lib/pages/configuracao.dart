import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  TextEditingController _controllerNomeConfig = TextEditingController();
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
    storage
        .child('perfil')
        .child('usuario')
        .child('${_usuarioLogado!.uid}.jpg')
        .putFile(_imagem!);

  }

  Future _recuperarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _usuarioLogado = await auth.currentUser;
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
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/whatsapp-flutter-58532.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=68da9248-5126-43a4-8aca-2d8852cbfd37'),
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
                      child: Text('Salvar'),
                    ))
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
