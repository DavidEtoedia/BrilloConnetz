import 'package:brillo_connetz/data/model/sign_up_req.dart';
import 'package:brillo_connetz/presentation/auth/vm/sign_up_vm.dart';
import 'package:brillo_connetz/presentation/auth/widget/chips_model.dart';
import 'package:brillo_connetz/presentation/helper/form_validator.dart';
import 'package:brillo_connetz/presentation/utils/app_color.dart';
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

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String isSelected = "";
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final signUp = ref.watch(signUpProvider);
    final email = useTextEditingController();
    final username = useTextEditingController();
    final phoneNumber = useTextEditingController();
    final password = useTextEditingController();

    ref.listen<AsyncValue>(signUpProvider, (_, value) {
      if (value is AsyncData<AuthResponse>) {
        ScreenAlertView.showInfoDialog(
            context: context,
            info: "Check your email ${email.text} for confirmation");
        // context.navigate(const LoginScreen());
      }
      if (value is AsyncError) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: value.error.toString());
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Space(40),
                  Text("️Sign Up",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 50,
                            letterSpacing: 0.0,
                          )),
                  const Space(40),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 3.5)),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormInput(
                      labelText: "Username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey.shade300,
                      ),
                      controller: username,
                      keyboardType: TextInputType.name,
                      validator: (value) => validateName(value),
                    ),
                  ),
                  const Space(20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 3.5)),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormInput(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.grey.shade300,
                      ),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validatePassword(value),
                    ),
                  ),
                  const Space(20),
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
                      labelText: "Phone number",
                      controller: phoneNumber,
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.grey.shade300,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => validatePhoneNumber(value),
                    ),
                  ),
                  const Space(20),
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
                      obscureText: obscure,
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.grey.shade300,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () => setState(() {
                                obscure = !obscure;
                              }),
                          child: Icon(
                            obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off,
                            color: Colors.grey.shade400,
                            size: 20,
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => null,
                    ),
                  ),
                  const Space(30),
                  Text(
                    "Select interest: ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.captionColor,
                        fontSize: 16,
                        letterSpacing: 0.6,
                        height: 1.5),
                  ),
                  const Space(15),
                  Wrap(
                    children: List.generate(chipcontentList.length, (index) {
                      final chips = chipcontentList[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ActionChip(
                          backgroundColor: isSelected == chips.name
                              ? AppColors.secondaryColor
                              : Colors.white,
                          shape: StadiumBorder(
                              side: BorderSide(
                            width: 1,
                            color: isSelected == chips.name
                                ? Colors.white
                                : Colors.grey.shade300,
                          )),
                          padding: const EdgeInsets.all(10),
                          avatar: Image.asset(chips.image),
                          label: Text(chips.name),
                          onPressed: () {
                            setState(() {
                              isSelected = chips.name;
                            });
                          },
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: isSelected == chips.name
                                      ? Colors.white
                                      : AppColors.captionColor,
                                  fontSize: 13,
                                  height: 1.5),
                        ),
                      );
                    }),
                  ),
                  const Space(65),
                  Animate(
                    child: AppButton(
                        isLoading: signUp.isLoading,
                        onPressed: signUp.isLoading
                            ? null
                            : () {
                                if (email.text.isEmpty ||
                                    username.text.isEmpty ||
                                    password.text.isEmpty ||
                                    phoneNumber.text.isEmpty ||
                                    isSelected.isEmpty) {
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  var signUpReq = SignUpReq(
                                      username: username.text,
                                      password: password.text,
                                      phone: phoneNumber.text,
                                      email: email.text,
                                      interest: isSelected);
                                  ref
                                      .read(signUpProvider.notifier)
                                      .signUp(signUpReq);
                                }
                              },
                        text: "Sign up"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.captionColor,
                            fontSize: 15,
                            letterSpacing: 0.0,
                            height: 1.5),
                      ),
                      ClickableText(
                          color: Colors.blue,
                          textSize: 15,
                          text: "Login",
                          onPressed: () => context.popView())
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
