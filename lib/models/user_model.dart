class UserModel {
  final String id;
  final String name;
  final String email;
  final String userType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'userType': userType,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userType: json['userType'] ?? '',
    );
  }
}
