import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<AuthResponse>>(
        (ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<AsyncValue<AuthResponse>> {
  final Ref ref;
  LoginNotifier(this.ref) : super(AsyncData(AuthResponse()));

  void login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(authImplProvider).login(email, password));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
