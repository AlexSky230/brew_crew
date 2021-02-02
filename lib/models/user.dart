class AppUser {

  final String uid;
  final bool isBarista ;

  AppUser({ this.uid, this.isBarista });

}

class UserData {

  final String uid;
  final String name;
  final String type;
  final String sugars;
  final int size;

  UserData({this.uid, this.name, this.type, this.sugars, this.size});

}
