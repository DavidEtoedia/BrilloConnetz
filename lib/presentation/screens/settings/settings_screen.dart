import 'package:brillo_connetz/data/service/auth_service.dart';
import 'package:brillo_connetz/presentation/screens/settings/screen/change_password.dart';
import 'package:brillo_connetz/presentation/screens/settings/screen/change_username.dart';
import 'package:brillo_connetz/presentation/screens/settings/widget/card_content.dart';
import 'package:brillo_connetz/presentation/utils/navigator/navigator.dart';
import 'package:brillo_connetz/presentation/utils/space.dart';
import 'package:brillo_connetz/presentation/widgets/clickable_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends StatefulHookConsumerWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: Column(
            children: [
              Space(50),
              Text("Settings and Privacy",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        letterSpacing: 0.0,
                      )),
              Space(50),
              Column(
                children: List.generate(general.length, (index) {
                  final result = general[index];
                  return ClickableCard(
                      title: result.title,
                      press: () {
                        switch (result.title) {
                          case "Change username":
                            context.navigate(ChangeUserName());
                            break;
                          case "Change password":
                            context.navigate(const ChangePassword());
                            break;

                          default:
                        }
                      });
                }),
              ),
              Space(30),
              ClickableCard(
                  title: "Log out",
                  islogOut: true,
                  press: () {
                    ref.read(authServiceProvider).signout();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
