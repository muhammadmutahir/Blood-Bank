class UserModel {
  final String id;
  final String name;
  final String email;
  final String userType;
  final String? imageUrl;

  /// Added the imageUrl parameter

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.imageUrl,

    /// Added the imageUrl parameter
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'userType': userType,
        'imageUrl': imageUrl,

        /// Added the imageUrl parameter
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userType: json['userType'] ?? '',
      imageUrl: json['imageUrl'],

      /// Added the imageUrl parameter
    );
  }
}
