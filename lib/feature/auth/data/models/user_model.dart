class UserModel {
  final String name;
  final String email;
  final String password;
  final String? image;
  final String? visa;
  final String? token;
  final String? address;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.image,
    this.visa,
    this.token,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      visa: json['Visa'],
      token: json['token'],
      address: json['address'],
    );
  }
}
