import 'package:flutter/material.dart';
import 'package:sky_brew_crew/common/constants.dart';
import 'package:sky_brew_crew/common/loading.dart';
import 'package:sky_brew_crew/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //validation form key
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0,
          title: Text('Sign up to Coffee Crew'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              colorFilter: new ColorFilter.mode(Colors.brown.withOpacity(0.3), BlendMode.multiply),
              fit: BoxFit.cover,
            )
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _emailController.clear();
                      }),
                ),
                validator: (val) => (val.isEmpty ||
                    val.indexOf('@inthecode.com.au') == -1)
                    ? 'Please provide valid ITC email'
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
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _passController.clear();
                      }),
                ),
                validator: (val) => val.length < 6
                    ? 'Password must be longer then 5 characters'
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
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    this.loading = true;

                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        error = 'Please supply valid email and password';
                        this.loading = false;
                      });
                    }
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
