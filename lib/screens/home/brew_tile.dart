import 'package:flutter/material.dart';
import 'package:sky_brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  int iconRadius;

  String getSizeLetter(int size) {
    switch (size) {
      case 1:
        {
          return 'S';
        }
      case 3:
        {
          return 'L';
        }
      default:
        {
          return 'M';
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
          isThreeLine: brew.type.length > 20,
          leading: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/coffee_icon.png'),
                radius: 30,
                backgroundColor: Colors.brown[800],
              ),
              Text(
                getSizeLetter(brew.size),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          title: Text(brew.name),
          subtitle: Text('${brew.type} with ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
