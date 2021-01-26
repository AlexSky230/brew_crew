import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_brew_crew/models/brew.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
   //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength, String type) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
      'type': type,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
        type: doc.data()['type'] ?? '',
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshots);
  }

}