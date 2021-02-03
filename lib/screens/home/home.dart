import 'package:flutter/material.dart';
import 'package:sky_brew_crew/common/decoration_constants.dart';
import 'package:sky_brew_crew/models/brew.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/screens/home/settings_form.dart';
import 'package:sky_brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/services/database.dart';
import 'package:intl/intl.dart';
import 'package:sky_brew_crew/common/text_constants.dart' as text;

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final String now = DateFormat("MMM-dd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(isScrollControlled: true, context: context, builder: (context) {
        return SettingsForm();
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(text.coffeeTrain),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text(text.logOut),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !user.isBarista,
          child: FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: () => _showSettingsPanel(),
            child: Icon(Icons.add, size: 30),
            ),
        ),
        body: Container(
          decoration: backgroundImage,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      text.activeOrders,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 200),
                      child: Container(
                        height: MediaQuery.of(context).size.height - 138,
                        child: BrewList()
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
