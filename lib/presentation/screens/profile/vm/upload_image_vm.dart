import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:brillo_connetz/presentation/screens/profile/image_upload/cloudinary_vm.dart';
import 'package:brillo_connetz/presentation/screens/profile/image_upload/image_picker_impl.dart';
import 'package:brillo_connetz/presentation/screens/profile/vm/user_profile_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadImageProvider =
    StateNotifierProvider.autoDispose<UploadImageNotifier, AsyncValue<dynamic>>(
        (ref) {
  return UploadImageNotifier(ref);
});

class UploadImageNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  UploadImageNotifier(this.ref) : super(AsyncData(dynamic));

  void uploadImage() async {
    try {
      final image = await ref.read(pickImageImpProvider).getImage();
      state = const AsyncValue.loading();
      final res =
          await ref.read(cloudinaryUploadProvider).cloudinaryUpload(image);

      state = await AsyncValue.guard(
          () => ref.read(authImplProvider).uploadAvatar(res));
      if (!state.hasError) {
        ref.invalidate(userProfileProvider);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
