class DonorUserModel {
  String id;
  final String fullname;
  final String email;
  final int age;
  final String bloodgroup;
  final String city;
  final String contactno;
  final String password;
  final String? imageUrl;

  DonorUserModel(
      {this.id = '',
      required this.fullname,
      required this.email,
      required this.age,
      required this.bloodgroup,
      required this.city,
      required this.contactno,
      required this.password,
      required this.imageUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'age': age,
        'bloodgroup': bloodgroup,
        'city': city,
        'contactno': contactno,
        'password': password,
        'imageUrl': imageUrl,
      };

  factory DonorUserModel.fromJson(Map<String, dynamic> json) {
    return DonorUserModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      bloodgroup: json['bloodgroup'] ?? '',
      city: json['city'] ?? '',
      contactno: json['contactno'] ?? '',
      password: json['password'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}
