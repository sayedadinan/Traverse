class Profile {
  int? id;
  final String username;
  final String email;
  final String password;
  final dynamic imagex;
  Profile({
    required this.username,
    required this.email,
    required this.password,
    this.imagex,
    this.id,
  });
  static Profile fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int;
    final username = map['username'] as String;
    final email = map['email'] as String;
    final password = map['password'] as String;
    final imagex = map['imagex'] as dynamic;

    return Profile(
        username: username,
        email: email,
        password: password,
        imagex: imagex,
        id: id);
  }
}
