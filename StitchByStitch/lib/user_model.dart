/*
ChatGpt used for generating user_model.dart
Defines the structure of a user, including username, password, email, and uploaded images. 
It provides methods to convert user data to/from JSON format.
*/

class User {
  final String username;
  late final String password;
  late final String email;
  List<String> uploads; // List of image paths

  User({required this.username, required this.password, required this.email, required this.uploads}); //mandatory fields for user object


// converts user object to json format 
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'uploads': uploads,
    };
  }


//converts json data to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      uploads: List<String>.from(json['uploads'] ?? []),
    );
  }
}


// takes list of user Objects, converts it to json format and json data to UserList object
class UserList {
  final List<User> users;

  UserList({required this.users});

  Map<String, dynamic> toJson() {
    return {'users': users.map((user) => user.toJson()).toList()};
  }

  factory UserList.fromJson(Map<String, dynamic> json) {
    var list = json['users'] as List;
    return UserList(users: list.map((item) => User.fromJson(item)).toList());
  }
}





