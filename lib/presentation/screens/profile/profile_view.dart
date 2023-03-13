import 'package:brillo_connetz/data/model/user_profile.dart';
import 'package:brillo_connetz/presentation/screens/profile/vm/upload_image_vm.dart';
import 'package:brillo_connetz/presentation/screens/profile/widget/profile_image.dart';
import 'package:brillo_connetz/presentation/utils/app_image.dart';
import 'package:brillo_connetz/presentation/utils/dialog/screen_dialog.dart';
import 'package:brillo_connetz/presentation/utils/space.dart';
import 'package:brillo_connetz/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends StatefulHookConsumerWidget {
  final UserProfile userProfile;
  const ProfileView({super.key, required this.userProfile});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final image = ref.watch(uploadImageProvider);
    ref.listen<AsyncValue>(uploadImageProvider, (_, value) {
      if (value is AsyncData<dynamic>) {}
      if (value is AsyncError) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: value.error.toString());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProfileImage(
                  isloading: image.isLoading,
                  imageUrl: widget.userProfile.avatar,
                ),
              ),
              Space(10),
              Center(
                child: ClickableText(
                    color: Colors.blue,
                    text: "Change Image",
                    onPressed: () {
                      ref.read(uploadImageProvider.notifier).uploadImage();
                    }),
              ),
              Space(40),
              ProfileCard(text: widget.userProfile.username),
              Space(20),
              ProfileCard(text: widget.userProfile.email),
              Space(20),
              ProfileCard(text: widget.userProfile.phone),
              Space(20),
              ProfileCard(isInterest: true, text: widget.userProfile.interest),
              Space(20),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String text;
  final bool isInterest;
  const ProfileCard({super.key, required this.text, this.isInterest = false});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: screenW,
      padding: EdgeInsets.only(
        right: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 3.5)),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isInterest) ...[
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                interestIcon(text),
              ),
            ),
            Space(10)
          ],
          Text(text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 0.0,
                  )),
        ],
      ),
    );
  }
}

String interestIcon(String name) {
  if (name == "Soccer") {
    return AppImage.soccer;
  } else if (name == "Basketball") {
    return AppImage.basketball;
  } else if (name == "Baseball") {
    return AppImage.baseball;
  } else if (name == "Tennis") {
    return AppImage.tennis;
  } else if (name == "Football") {
    return AppImage.americanFb;
  } else {
    return AppImage.tennis;
  }
}
