class User {
  String username;
  String phoneNumber;

  User({required this.username, required this.phoneNumber});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      phoneNumber: data['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}
