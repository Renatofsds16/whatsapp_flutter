class Usuario{
  String _nome = '';
  String? _email = '';
  String _senha = '';
  String? _urlFoto;


  Usuario();

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      'nome': nome,
      'email': email,
    'url': urlFoto
    };
    return map;
  }

  String? get urlFoto => _urlFoto;

  set urlFoto(String? value) {
    _urlFoto = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}