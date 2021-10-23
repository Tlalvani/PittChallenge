import 'package:pitt_challenge/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pitt_challenge/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currUser;
  AUser userFirebase(User user) {
    return user != null ? AUser(uid: user.uid) : null;
  }

  Stream<AUser> get user{
    return _auth.authStateChanges()
      .map(userFirebase);
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }

  Future registerAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


}