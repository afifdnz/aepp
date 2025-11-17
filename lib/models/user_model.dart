class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String? dob;

  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.dob,
    required this.password,
  });
}
