// ignore_for_file: public_member_api_docs, sort_constructors_first

class SignUpReq {
  String username;
  String password;
  String phone;
  String email;
  String interest;
  String? avatar;
  SignUpReq({
    required this.username,
    required this.password,
    required this.phone,
    required this.email,
    required this.interest,
    this.avatar,
  });
}
