import 'dart:developer';

import 'package:brillo_connetz/presentation/auth/login.dart';
import 'package:brillo_connetz/presentation/home_page.dart';
import 'package:brillo_connetz/presentation/utils/navigator/navigator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

/// SUPABASE CLIENT PROVIDER
final supaBaseClientProvider = riverpod.Provider((ref) {
  return Supabase.instance.client;
});

/// AUTH CHANGE STREAM PROVIDER
final authStateProvider = riverpod.StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

/// THIS CLASS LISTENS TO AUTH CHANGE

class AuthChangeState {
  final riverpod.Ref ref;
  AuthChangeState(this.ref) {
    _init();
  }

  void _init() {
    ref.listen<riverpod.AsyncValue<AuthState>>(authStateProvider, (_, value) {
      if (value is riverpod.AsyncData<AuthState>) {
        if (navigator.key.currentContext == null) return;
        if ((value.value.event == AuthChangeEvent.signedIn)) {
          print(navigator.key.currentState);

          navigator.key.currentContext!.navigateReplaceRoot(HomePage());
        } else if ((value.value.event == AuthChangeEvent.signedOut) ||
            (value.value.session == null)) {
          navigator.key.currentContext!.navigateReplaceRoot(LoginScreen());
        }
      }
      if (value is riverpod.AsyncError) {
        log("error");
      }
    });
  }
}

final authChangeServiceProvider = riverpod.Provider<AuthChangeState>((ref) {
  return AuthChangeState(ref);
});
