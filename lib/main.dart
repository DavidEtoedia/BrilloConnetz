import 'package:brillo_connetz/data/core/core.dart';
import 'package:brillo_connetz/data/providers/auth_state_provider.dart';
import 'package:brillo_connetz/presentation/auth_home.dart';
import 'package:brillo_connetz/presentation/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialize();
  // 1. Create a ProviderContainer
  final container = ProviderContainer();
  // 2. Use it to read the provider
  container.read(authChangeServiceProvider);
  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.key,
      title: 'Brillo_Connetz',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade50,
          textTheme: GoogleFonts.mulishTextTheme(textTheme).copyWith(
            bodySmall: GoogleFonts.mulish(textStyle: textTheme.bodySmall),
            bodyMedium: GoogleFonts.mulish(textStyle: textTheme.bodyMedium),
            bodyLarge: GoogleFonts.spaceGrotesk(textStyle: textTheme.bodyLarge),
            labelMedium: GoogleFonts.mulish(textStyle: textTheme.labelMedium),
            labelSmall: GoogleFonts.mulish(textStyle: textTheme.labelSmall),
          ),
          primarySwatch: Colors.blue),
      home: const AuthHome(),
    );
  }
}
