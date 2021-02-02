import 'package:flutter/material.dart';
import 'package:sky_brew_crew/models/brew.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/screens/home/settings_form.dart';
import 'package:sky_brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/services/database.dart';
import 'package:intl/intl.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final String now = DateFormat("MMM-dd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(isScrollControlled: true, context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Log out'),
            ),
            Visibility(
              visible: !user.isBarista,
              child: FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.brown.withOpacity(0.3), BlendMode.multiply),
            )
          ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    'Active orders:',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  SingleChildScrollView(
                      child: Container(height: 600, child: BrewList())
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
