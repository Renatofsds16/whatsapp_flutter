import 'package:firebase_auth/firebase_auth.dart';

class HelpFirebaseAuth{
  static final HelpFirebaseAuth _helpFirebaseAuth =
  HelpFirebaseAuth.internal();
  HelpFirebaseAuth.internal();
  factory HelpFirebaseAuth() {
    return _helpFirebaseAuth;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  createUserWithEmailAndPassword(String email,String password) async{
    UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .catchError(
        (error){
          print('esse foi o error ao cria usuario ' + error.toString());
        }
    );
    return user;
  }
  Future<UserCredential> loginUser(String email,String password)async{
    UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password)
        .catchError((error){print('esse foi o error logar usuario ' + error.toString());});
    return user;
  }
  exitUser()async{
    await _auth.signOut();
  }
  currentUser(){
    User? user = _auth.currentUser;
    if(user != null){
      return user;
    }
  }
}