class SeekerUserModel {
  String id;
  final String fullname;
  final String email;
  final String password;
  final String? imageUrl;

  /// Added the imageUrl parameter

  SeekerUserModel(
      {this.id = '',
      required this.fullname,
      required this.email,
      required this.password,
      required this.imageUrl});

  /// Added the imageUrl parameter

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'password': password,
        'imageUrl': imageUrl,

        /// Added the imageUrl parameter
      };

  factory SeekerUserModel.fromJson(Map<String, dynamic> json) {
    return SeekerUserModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      imageUrl: json['imageUrl'],

      /// Added the imageUrl parameter
    );
  }
}
