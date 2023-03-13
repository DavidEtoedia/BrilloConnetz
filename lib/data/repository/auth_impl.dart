import 'package:brillo_connetz/data/model/sign_up_req.dart';
import 'package:brillo_connetz/data/model/user_profile.dart';
import 'package:brillo_connetz/data/repository/auth_interface.dart';
import 'package:brillo_connetz/data/service/auth_service.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final authImplProvider = riverpod.Provider((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthImpl(authService);
});

class AuthImpl implements AuthInterface {
  final AuthService authService;
  AuthImpl(this.authService);

  @override
  Future<AuthResponse> login(String email, String password) async =>
      await authService.login(email, password);

  @override
  Future<AuthResponse> signUp(SignUpReq signUpReq) async =>
      await authService.signUp(signUpReq);

  @override
  Future<UserProfile> currentUser() async => await authService.currentUser();

  @override
  Future<User> changePassword(String password) async =>
      await authService.changePassword(password);

  @override
  Future updateUserName(String username) async =>
      await authService.updateUserName(username);

  @override
  Future uploadAvatar(String avatar) async =>
      await authService.uploadAvatar(avatar);
}
