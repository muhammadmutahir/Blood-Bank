class SeekerUserModel {
  String id;
  final String fullname;
  final String email;
  final String username;
  final String password;

  SeekerUserModel(
      {this.id = '',
      required this.fullname,
      required this.email,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'username': username,
        'password': password,
      };

  factory SeekerUserModel.fromJson(Map<String, dynamic> json) {
    return SeekerUserModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
