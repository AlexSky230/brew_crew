import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create AppUser based on Firebase User
  AppUser _userFromFireUser(User user, bool isBarista) {
    return user != null ? AppUser(uid: user.uid, isBarista: isBarista) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
        .map((User user) {
          bool isBarista = (user?.email == null);
          return _userFromFireUser(user, isBarista);
        });

  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireUser(user, true);
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
      return _userFromFireUser(user, false);
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

      await DatabaseService(uid: user.uid).updateUserData(false, '0', 'New member', 1, 'Nothing for now');

      return _userFromFireUser(user, false);
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