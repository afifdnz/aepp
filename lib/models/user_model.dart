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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['ID'] ?? 0,
      name: json['name'] ?? json['Name'] ?? '',
      email: json['email'] ?? json['Email'] ?? '',
      username: json['username'] ?? json['Username'] ?? '',
      dob: json['TanggalLahir'] ?? json['tanggal_lahir'] ?? json['dob'],
      password: '',
    );
  }
}
