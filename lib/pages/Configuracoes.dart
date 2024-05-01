import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final TextEditingController _controllerNome = TextEditingController();
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
              const CircleAvatar(
                maxRadius: 120,
                backgroundColor: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {_tirarFoto();},
                            child: const Text('Camera'),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {_escolherFoto();},
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
                    onPressed: () {},
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
  _escolherFoto(){
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.gallery);
  }

  _tirarFoto(){
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.camera);
  }
}
