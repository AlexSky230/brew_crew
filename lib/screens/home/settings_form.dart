import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/common/constants.dart';
import 'package:sky_brew_crew/common/loading.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/services/database.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  String _currentType;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Update your brew settings:',
                  style: TextStyle(
                      fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[600],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: userData.type,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please specify your beverage' : null,
                  onChanged: (val) => setState(() => _currentType = val),
                ),
                SizedBox(height: 10),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) {
                    setState(() =>_currentStrength = val.round());
                  },
                ),
                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength,
                          _currentType ?? userData.type,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 100),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}

