import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_brew_crew/models/brew.dart';
import 'package:sky_brew_crew/screens/home/brew_list.dart';
import 'package:sky_brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Log out'),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
