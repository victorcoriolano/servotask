class UserModel {
  final String name;
  final String email;
  final String? uid;
  final String? token;
  final String? creationDate;

  UserModel(
      {required this.name,
      required this.email,
      required this.uid,
      this.token,
      this.creationDate});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}
