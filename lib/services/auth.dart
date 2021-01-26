import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create AppUser based on Firebase User
  AppUser _userFromFireUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
        // .map((User user) => _userFromFireUser(user));
    .map(_userFromFireUser); // same as line above, but better not to rely on it
  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFireUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew dude', 100, 'cappuccino');

      return _userFromFireUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}