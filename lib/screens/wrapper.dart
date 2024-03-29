import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_brew_crew/models/user.dart';
import 'package:sky_brew_crew/screens/authenticate/authenticate.dart';
import 'package:sky_brew_crew/screens/home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    //TODO return either home or authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
