import 'package:brillo_connetz/data/model/sign_up_req.dart';
import 'package:brillo_connetz/data/model/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthInterface {
  Future<UserProfile> currentUser();
  Future<AuthResponse> signUp(SignUpReq signUpReq);
  Future<AuthResponse> login(String email, String password);
  Future<User> changePassword(String password);
  Future<dynamic> updateUserName(String username);
  Future<dynamic> uploadAvatar(String avatar);
}
