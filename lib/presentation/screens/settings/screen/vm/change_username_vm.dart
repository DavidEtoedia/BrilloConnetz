import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:brillo_connetz/presentation/screens/profile/vm/user_profile_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final changeUserNameProvider = StateNotifierProvider.autoDispose<
    ChangeUserNameNotifier, AsyncValue<dynamic>>((ref) {
  return ChangeUserNameNotifier(ref);
});

class ChangeUserNameNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  ChangeUserNameNotifier(this.ref) : super(AsyncData(dynamic));

  void updateUsername(String username) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(authImplProvider).updateUserName(username));
      if (!state.hasError) {
        ref.invalidate(userProfileProvider);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
