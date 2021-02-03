import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/models/brew.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/common/text_constants.dart' as text;

class BrewTile extends StatefulWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  _BrewTileState createState() => _BrewTileState();
}

class _BrewTileState extends State<BrewTile> {
  int iconRadius;

  bool isOrderDone = false;

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
    final user = Provider.of<AppUser>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          minVerticalPadding: 10,
          trailing: IconButton(
            onPressed: user.isBarista ? () {
              setState(() => isOrderDone = !isOrderDone);
            } : null,
            icon: Icon(Icons.check, color: isOrderDone ? Colors.pink : Colors.grey),
          ),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(text.coffeeIconUrl),
                radius: 30,
                backgroundColor: Colors.brown[800],
              ),
              Text(
                getSizeLetter(widget.brew.size),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          title: Text(widget.brew.name),
          subtitle: Text('${widget.brew.type} with ${widget.brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
