import 'package:brillo_connetz/data/model/sign_up_req.dart';
import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, AsyncValue<AuthResponse>>(
        (ref) {
  return SignUpNotifier(ref);
});

class SignUpNotifier extends StateNotifier<AsyncValue<AuthResponse>> {
  final Ref ref;
  SignUpNotifier(this.ref) : super(AsyncData(AuthResponse()));

  void signUp(SignUpReq signUpReq) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(authImplProvider).signUp(signUpReq));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
