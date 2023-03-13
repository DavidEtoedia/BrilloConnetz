import 'package:brillo_connetz/presentation/utils/app_color.dart';
import 'package:brillo_connetz/presentation/utils/app_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileImage extends HookConsumerWidget {
  final String? imageUrl;
  final bool isloading;
  const ProfileImage(
      {super.key, required this.imageUrl, this.isloading = false});

  @override
  Widget build(BuildContext context, ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(55),
      child: isloading
          ? Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 5,
                      offset: const Offset(4, 3)),
                ],
              ),
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 90,
              width: 90,
              child: (imageUrl == null || imageUrl!.isEmpty)
                  ? Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              scale: 3,
                              image: AssetImage(
                                AppImage.userImage,
                              ))),
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageUrl.toString(),
                      placeholder: (context, url) => Container(
                          color: AppColors.secondaryColor,
                          child: Image.asset(
                            AppImage.userImage,
                            scale: 4,
                          )),
                      errorWidget: (context, url, error) => Container(
                          color: AppColors.secondaryColor,
                          child: Image.asset(
                            AppImage.userImage,
                            scale: 3,
                          )),
                    ),
            ),
    );
  }
}
