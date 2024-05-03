class DonorUserModel {
  String id;
  final String fullname;
  final String email;
  final String username;
  final int age;
  final String bloodgroup;
  final String city;
  final String contactno;
  final String password;

  DonorUserModel({
    this.id = '',
    required this.fullname,
    required this.email,
    required this.username,
    required this.age,
    required this.bloodgroup,
    required this.city,
    required this.contactno,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'username': username,
        'age': age,
        'bloodgroup': bloodgroup,
        'city': city,
        'contactno': contactno,
        'password': password,
      };

  factory DonorUserModel.fromJson(Map<String, dynamic> json) {
    return DonorUserModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      age: json['age'] ?? 0,
      bloodgroup: json['bloodgroup'] ?? '',
      city: json['city'] ?? '',
      contactno: json['contactno'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
