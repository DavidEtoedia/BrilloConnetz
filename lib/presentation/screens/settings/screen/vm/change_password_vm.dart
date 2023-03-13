import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final changePasswordProvider =
    StateNotifierProvider.autoDispose<ChangePasswordNotifier, AsyncValue<User>>(
        (ref) {
  return ChangePasswordNotifier(ref);
});

class ChangePasswordNotifier extends StateNotifier<AsyncValue<User>> {
  final Ref ref;
  ChangePasswordNotifier(this.ref)
      : super(AsyncData(User(
            appMetadata: {},
            aud: '',
            id: '',
            userMetadata: {},
            createdAt: '')));

  void changePassword(String password) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(authImplProvider).changePassword(password));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
