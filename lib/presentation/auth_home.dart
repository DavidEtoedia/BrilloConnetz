import 'package:brillo_connetz/data/providers/auth_state_provider.dart';
import 'package:brillo_connetz/presentation/auth/login.dart';
import 'package:brillo_connetz/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthHome extends ConsumerStatefulWidget {
  const AuthHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthHomeState();
}

class _AuthHomeState extends ConsumerState<AuthHome> {
  bool isLoggedIn = false;

  @override
  void initState() {
    authStateChange();
    super.initState();
  }

  void authStateChange() async {
    final user = await ref.read(supaBaseClientProvider).auth;
    if (user.currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });
    }

    await Future.delayed(Duration(milliseconds: 3000));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return HomePage();
    } else {
      return LoginScreen();
    }
  }
}
