import 'package:flutter/material.dart';
import 'package:sky_brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});

  int iconRadius;

  double setIconRadius(int size) {
    switch (size) {
      case 1: {
        return 10;
      }
      case 3: {
        return 30;
      }
      default: {
        return 20;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/coffee_icon.png'),
            radius: setIconRadius(brew.size),
            backgroundColor: Colors.brown[brew.size * 200],
          ),
          title: Text(brew.name),
          subtitle: Text('${brew.type} with ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
