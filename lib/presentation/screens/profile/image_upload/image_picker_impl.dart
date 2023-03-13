import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider((ref) {
  return ImagePicker();
});

final pickImageImpProvider = Provider((ref) {
  return UploadImage(ref);
});

class UploadImage {
  final Ref ref;

  UploadImage(
    this.ref,
  );

  Future<String> getImage() async {
    final XFile? image = await ref
        .read(imagePickerProvider)
        .pickImage(source: ImageSource.gallery);

    if (image == null) {
      return "";
    } else {
      final imageFile = File(image.path);
      // final appDir = await path_provider.getApplicationDocumentsDirectory();

      // // This is the saved image path
      // // You can use it to display the saved image later
      // final localPath = path.join(appDir.path, imageFile.path);
      return imageFile.path;
    }
  }
}
