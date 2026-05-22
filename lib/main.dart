import 'package:flutter/material.dart';
import 'package:odontologia_app/features/home/presentation/screens/home_screen.dart';

import 'core/theme/app_theme.dart';
import 'shared/widgets/main_navigation.dart';
import 'features/reader/presentation/screens/reader_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      theme: AppTheme.light,

      darkTheme: ThemeData.dark(),

      // home: const MainNavigation(),
      home: const LoginScreen(),
    );
  }
}
