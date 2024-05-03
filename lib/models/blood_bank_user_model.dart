class BloodBankUserModel {
  String id;
  final String bloodbankname;
  final String email;
  final String bloodgroup;
  final int availablebloodunit;
  final String contactno;
  final String password;
  final String city;

  BloodBankUserModel({
    this.id = '',
    required this.bloodbankname,
    required this.email,
    required this.bloodgroup,
    required this.availablebloodunit,
    required this.contactno,
    required this.password,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'bloodbankname': bloodbankname,
        'email': email,
        'bloodgroup': bloodgroup,
        'availablebloodunit': availablebloodunit,
        'contactno': contactno,
        'password': password,
        'city': city,
      };

  factory BloodBankUserModel.fromJson(Map<String, dynamic> json) {
    return BloodBankUserModel(
      id: json['id'] ?? '',
      bloodbankname: json['bloodbankname'] ?? '',
      email: json['email'] ?? '',
      bloodgroup: json['bloodgroup'] ?? '',
      availablebloodunit: json['availablebloodunit'] ?? 0,
      contactno: json['contactno'] ?? '',
      password: json['password'] ?? '',
      city: json['city'] ?? '',
    );
  }
}
