

class Person {
  String name;
  String email;
  String password;
  String? photoUrl;
  String userRoll;

  Person({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
    required this.userRoll
  });
}
