import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'shared/widgets/main_navigation.dart';
import 'features/reader/presentation/screens/reader_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const ProviderScope(child: MyApp()));
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

      home: const ReaderScreen(),
    );
  }
}
