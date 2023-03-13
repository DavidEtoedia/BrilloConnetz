import 'package:brillo_connetz/presentation/screens/profile/error_widget.dart';
import 'package:brillo_connetz/presentation/screens/profile/loading_screen.dart';
import 'package:brillo_connetz/presentation/screens/profile/profile_view.dart';
import 'package:brillo_connetz/presentation/screens/profile/vm/user_profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userprofile = ref.watch(userProfileProvider);
    return userprofile.maybeWhen(
        data: (data) {
          return ProfileView(userProfile: data);
        },
        error: (e, s) => ErrorScreen(error: e.toString()),
        orElse: () {
          return LoadingScreen();
        });
  }
}
