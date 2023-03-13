import 'package:brillo_connetz/presentation/auth/sign_up.dart';
import 'package:brillo_connetz/presentation/auth/vm/login_vm.dart';
import 'package:brillo_connetz/presentation/helper/form_validator.dart';
import 'package:brillo_connetz/presentation/home_page.dart';
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

class LoginScreen extends StatefulHookConsumerWidget {
  final String email;
  const LoginScreen({super.key, this.email = ""});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final login = ref.watch(loginProvider);
    final email = useTextEditingController(text: widget.email);
    final password = useTextEditingController();

    ref.listen<AsyncValue>(loginProvider, (_, value) {
      if (value is AsyncData<AuthResponse>) {
        if (value.value.user != null) {
          context.navigateReplace(const HomePage());
        }
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Space(50),
                  Text("️Login",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 50,
                            letterSpacing: 0.0,
                          )),
                  const Space(50),
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
                      validator: (value) => validateEmail(value),
                    ),
                  ),
                  const Space(40),
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
                      keyboardType: TextInputType.visiblePassword,
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
                      validator: (value) => validatePassword(value),
                    ),
                  ),
                  const Space(65),
                  Animate(
                    child: AppButton(
                        isLoading: login.isLoading,
                        onPressed: login.isLoading
                            ? null
                            : () {
                                if (email.text.isEmpty ||
                                    password.text.isEmpty) {
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }

                                  /// MAKE THE PASSWORD NOT VISIBLE IF IT WAS VISIBLE
                                  if (!obscure) {
                                    setState(() => obscure = true);
                                  }

                                  ref
                                      .read(loginProvider.notifier)
                                      .login(email.text, password.text);
                                }
                              },
                        text: "Login"),
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
                  const Space(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.captionColor,
                            fontSize: 15,
                            letterSpacing: 0.6,
                            height: 1.5),
                      ),
                      ClickableText(
                          color: Colors.blue,
                          textSize: 15,
                          text: "Sign up",
                          onPressed: () =>
                              context.navigate(const SignUpScreen()))
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
