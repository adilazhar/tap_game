import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tap_game/src/tap/home_screen.dart';
import 'package:tap_game/src/utils/settings/application/app_setting_notifier.dart';

import 'package:tap_game/src/utils/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingNotifierProvider);

    return MaterialApp(
      title: 'Tap Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: settings.when(
        data: (data) {
          return const HomeScreen();
        },
        error: (error, _) => null,
        loading: () => const SplashScreen(),
      ),
    );
  }
}
