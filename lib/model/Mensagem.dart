class Mensagem{
  String idUsuario = '';
  String mensagem = '';
  String urlImagem = '';
  String tipo = '';

  Mensagem();

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      'idUsuario': this.idUsuario,
      'mensagem': this.idUsuario,
      'urlImagem': this.idUsuario,
      'tipo': this.idUsuario,
    };
    return map;
  }

}
