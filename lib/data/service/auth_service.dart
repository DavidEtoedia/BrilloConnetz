import 'package:brillo_connetz/data/model/sign_up_req.dart';
import 'package:brillo_connetz/data/model/user_profile.dart';
import 'package:brillo_connetz/data/providers/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = riverpod.Provider((ref) {
  return AuthService(ref);
});

class AuthService {
  final riverpod.Ref ref;

  AuthService(this.ref);

  ///CREATE ACCOUNT
  Future<AuthResponse> signUp(SignUpReq signUpReq) async {
    try {
      final res = await ref.read(supaBaseClientProvider).auth.signUp(
          email: signUpReq.email,
          password: signUpReq.password,
          emailRedirectTo: "io.supabase.flutterdemo://login-callback");
      if (res.user != null) {
        final updates = {
          'id': res.user?.id,
          'username': signUpReq.username,
          'avatar': '',
          'phone': signUpReq.phone,
          'email': res.user?.email,
          'interest': signUpReq.interest
        };

        await ref.read(supaBaseClientProvider).from('profile').insert(updates);
      }

      return res;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///LOGIN ACCOUNT
  Future<AuthResponse> login(String email, String password) async {
    try {
      final res = await ref
          .read(supaBaseClientProvider)
          .auth
          .signInWithPassword(email: email, password: password);

      return res;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///CHANGE PASSWORD
  Future<User> changePassword(String password) async {
    try {
      final res = await ref
          .read(supaBaseClientProvider)
          .auth
          .updateUser(UserAttributes(password: password));

      return res.user!;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///GET USER PROFILE ACCOUNT
  Future<UserProfile> currentUser() async {
    try {
      final id = ref.watch(supaBaseClientProvider).auth.currentUser;

      final res = await ref
          .read(supaBaseClientProvider)
          .from("profile")
          .select()
          .eq('id', id?.id)
          .single();
      final result = UserProfile.fromJson(res);

      return result;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///UPDATE USER
  Future<dynamic> updateUserName(String username) async {
    try {
      print("Here");
      final id = ref.watch(supaBaseClientProvider).auth.currentUser;
      final res = await ref
          .read(supaBaseClientProvider)
          .from("profile")
          .update({'username': username}).match({'id': id?.id});

      return res;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///UPLOAD AVATAR
  Future<dynamic> uploadAvatar(String avatar) async {
    try {
      print("Here");
      final id = ref.watch(supaBaseClientProvider).auth.currentUser;
      final res = await ref
          .read(supaBaseClientProvider)
          .from("profile")
          .update({'avatar': avatar}).match({'id': id?.id});
      return res;
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  ///LOGOUT ACCOUNT
  void signout() async {
    try {
      await ref.read(supaBaseClientProvider).auth.signOut();
    } on AuthException catch (e) {
      throw e.message;
    }
  }
}
