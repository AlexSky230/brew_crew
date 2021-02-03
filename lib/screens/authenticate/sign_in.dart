import 'package:flutter/material.dart';
import 'package:sky_brew_crew/common/decoration_constants.dart';
import 'package:sky_brew_crew/common/loading.dart';
import 'package:sky_brew_crew/services/auth.dart';
import 'package:sky_brew_crew/common/text_constants.dart' as text;

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //validation form key
  bool loading = false;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text(text.signIn),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text(text.register),
                ),
              ],
            ),
            body: Container(
              decoration: backgroundImage,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: textInputDecoration.copyWith(
                        hintText: text.email,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _emailController.clear();
                            }),
                      ),
                      validator: (val) => (val.isEmpty || val.indexOf(text.itcMail) == -1)
                          ? text.provideValidEmail
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passController,
                      decoration: textInputDecoration.copyWith(
                        hintText: text.password,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _passController.clear();
                            }),
                      ),
                      validator: (val) => val.length < 6
                          ? text.mustBeLonger
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        text.itcSignIn,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = text.incorrectPass;
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    Divider(height: 40, thickness: 1, color: Colors.black,),
                    Text(
                      text.notItc,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 15),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        text.baristaSignIn,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();

                        if (result == null) {
                          setState(() {
                            error = text.cantLogIn;
                            loading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
