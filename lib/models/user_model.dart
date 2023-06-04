// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory UserModel.defaultt() {
    return UserModel(
      userId: "0",
      firstName: "NONE",
      lastName: "NONE",
      email: "NONE@NONE.COM",
      image: "",
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: (map['userId'] ?? "") as String,
      firstName: (map['firstName'] ?? "") as String,
      lastName: (map['lastName'] ?? "") as String,
      email: (map['email'] ?? "") as String,
      image: (map['image'] ?? "") as String,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode;
  }
}
