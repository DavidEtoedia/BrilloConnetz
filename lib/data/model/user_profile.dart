// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

class UserProfile {
  UserProfile({
    required this.username,
    required this.phone,
    required this.email,
    required this.interest,
    required this.id,
    this.avatar,
  });
  String id;
  String username;
  String phone;
  String email;
  String interest;
  String? avatar;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        interest: json["interest"],
        avatar: json["avatar"],
      );
}
