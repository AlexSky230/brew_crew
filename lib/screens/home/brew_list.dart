import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sky_brew_crew/models/brew.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        },
      ),
    );
  }
}
