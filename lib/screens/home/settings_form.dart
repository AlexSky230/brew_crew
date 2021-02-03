import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/common/decoration_constants.dart';
import 'package:sky_brew_crew/common/loading.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/services/database.dart';
import 'package:sky_brew_crew/common/text_constants.dart' as text;

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  bool _currentIsOrderActive;
  int _currentSize;
  String _currentName;
  String _currentSizeLabel;
  String _currentSugars;
  String _currentType;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    String setCurrentSizeLabel(int size) {
      switch (size) {
        case 1:
          {
            return text.sm;
          }

        case 3:
          {
            return text.lg;
          }

        default:
          {
            return text.md;
          }
      }
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      text.updateOrder,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[600],
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(
                        hintText: text.name
                      ),
                      validator: (val) =>
                          val.isEmpty ? text.name : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: userData.type,
                      decoration: textInputDecoration.copyWith(
                          hintText: text.beverage
                      ),
                      validator: (val) =>
                          val.isEmpty ? text.specifyBeverage : null,
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
                          child: Text('$sugar ${text.sugars}'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'S',
                            style: TextStyle(
                                color: Colors.brown[200],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'M',
                            style: TextStyle(
                              color: Colors.brown[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'L',
                            style: TextStyle(
                              color: Colors.brown[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      label: setCurrentSizeLabel(_currentSize ?? userData.size),
                      value: (_currentSize ?? userData.size).toDouble(),
                      activeColor:
                          Colors.brown[(_currentSize ?? userData.size) * 200],
                      inactiveColor: Colors.brown[100],
                      min: 1,
                      max: 3,
                      divisions: 2,
                      onChanged: (val) {
                        setState(() {
                          _currentSize = val.round();
                          _currentSizeLabel = setCurrentSizeLabel(_currentSize);
                        });
                      },
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(text.makeActive, style: TextStyle(fontWeight: FontWeight.bold)),
                      activeColor: Colors.pink,
                      value: _currentIsOrderActive ?? userData.isOrderActive,
                      onChanged: (newValue) {
                        setState(() {
                          _currentIsOrderActive = newValue;
                        });
                      },
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        text.update,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentIsOrderActive ?? userData.isOrderActive,
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentSize ?? userData.size,
                            _currentType ?? userData.type,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
