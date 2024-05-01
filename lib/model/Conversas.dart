class ConversasModel{
  String _nomeUsuario = '';
  String _menssagem = '';
  String _caminhaoFoto = '';

  ConversasModel(this._nomeUsuario, this._menssagem, this._caminhaoFoto);

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  String get menssagem => _menssagem;

  String get caminhaoFoto => _caminhaoFoto;

  set caminhaoFoto(String value) {
    _caminhaoFoto = value;
  }

  set menssagem(String value) {
    _menssagem = value;
  }
}