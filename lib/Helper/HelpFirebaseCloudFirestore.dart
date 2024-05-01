import 'package:cloud_firestore/cloud_firestore.dart';
class HelpFirebaseCloudFirestore{
  static final HelpFirebaseCloudFirestore _helpFirebaseCloudFirestore =
  HelpFirebaseCloudFirestore.internal();
  HelpFirebaseCloudFirestore.internal();
  factory HelpFirebaseCloudFirestore() {
    return _helpFirebaseCloudFirestore;
  }
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  saveDataUser(String doc,Map<String,dynamic> map){
    _firebaseFirestore.collection('usuarios')
        .doc(doc).set(map);
  }

  Future<QuerySnapshot> recuperarDadosUsuarios()async{
     QuerySnapshot querySnapshot = await _firebaseFirestore.collection('usuarios').get();
     return querySnapshot;
  }
}