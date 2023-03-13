import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudinaryUploadProvider = Provider((ref) {
  return CloudinaryUpload(ref);
});

class CloudinaryUpload {
  final Ref ref;
  CloudinaryUpload(this.ref);

  Future<String> cloudinaryUpload(String filePath) async {
    var cloudinary = CloudinaryPublic('dnnxnfr6c', 'ouvoc5zb', cache: false);

    try {
      if (filePath.isEmpty) {
        return "";
      } else {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(filePath,
              resourceType: CloudinaryResourceType.Image),
        );

        return response.secureUrl;
      }
    } on SocketException catch (e) {
      throw e.message;
    } on CloudinaryException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
