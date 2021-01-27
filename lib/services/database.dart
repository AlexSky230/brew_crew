import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_brew_crew/models/brew.dart';
import 'package:sky_brew_crew/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
   //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int size, String type) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'size': size,
      'type': type,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc.data()['name']);
      return Brew(
        name: doc.data()['name'] ?? '',
        size: doc.data()['size'] ?? 2,
        sugars: doc.data()['sugars'] ?? '0',
        type: doc.data()['type'] ?? '',
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      type: snapshot.data()['type'],
      sugars: snapshot.data()['sugars'],
      size: snapshot.data()['size'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshots);
  }

  // get user doc stream

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}