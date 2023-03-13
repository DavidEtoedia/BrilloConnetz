import 'package:brillo_connetz/presentation/helper/form_validator.dart';
import 'package:brillo_connetz/presentation/screens/settings/screen/vm/change_password_vm.dart';
import 'package:brillo_connetz/presentation/utils/dialog/screen_dialog.dart';
import 'package:brillo_connetz/presentation/utils/navigator/navigator.dart';
import 'package:brillo_connetz/presentation/utils/space.dart';
import 'package:brillo_connetz/presentation/widgets/app_button.dart';
import 'package:brillo_connetz/presentation/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePassword extends StatefulHookConsumerWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final passwordReq = ref.watch(changePasswordProvider);
    final password = useTextEditingController();
    final confirmpassword = useTextEditingController();

    ref.listen<AsyncValue>(changePasswordProvider, (_, value) {
      if (value is AsyncData<User>) {
        if (!value.hasError) {
          context.popView();
        }
      }
      if (value is AsyncError) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: value.error.toString());
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Change Password",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          letterSpacing: 0.0,
                        )),
                Space(30),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3.5)),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormInput(
                    labelText: "Password",
                    controller: password,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => validatePassword(value),
                  ),
                ),
                Space(30),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 3.5)),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormInput(
                    labelText: "Confirm password",
                    controller: confirmpassword,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value != password.text) {
                        return "Password is not the same as new password";
                      }
                      return null;
                    },
                  ),
                ),
                Space(50),
                Animate(
                  child: AppButton(
                      isLoading: passwordReq.isLoading,
                      onPressed: passwordReq.isLoading
                          ? null
                          : () {
                              if (password.text.isEmpty ||
                                  confirmpassword.text.isEmpty) {
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                ref
                                    .read(changePasswordProvider.notifier)
                                    .changePassword(password.text);
                              }
                            },
                      text: "Save"),
                )
                    .animate()
                    .slideY(
                        curve: Curves.fastLinearToSlowEaseIn,
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 500),
                        begin: 30,
                        end: 0)
                    .fadeIn(
                      curve: Curves.linearToEaseOut,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 100),
                      // begin: 30,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
