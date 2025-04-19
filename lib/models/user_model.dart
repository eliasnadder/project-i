class UserModel {
  final String name;
  final String email;
  final String? phone;
  final String password;
  final String location;
  final String? photo;

  UserModel({
    required this.name,
    required this.email,
    this.phone,
    required this.password,
    required this.location,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'location': location,
      'image_path': photo,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, String? image) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: (json['phone'] is int).toString(),
      password: json['password'],
      location: json['location'],
      photo: image,
    );
  }
}
