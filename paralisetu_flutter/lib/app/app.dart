import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../providers/auth_provider.dart';
import '../features/auth/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';
import 'theme.dart';

class ParaliSetuApp extends ConsumerStatefulWidget {
  const ParaliSetuApp({super.key});

  @override
  ConsumerState<ParaliSetuApp> createState() => _ParaliSetuAppState();
}

class _ParaliSetuAppState extends ConsumerState<ParaliSetuApp> {
  bool _splashCompleted = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: !_splashCompleted
          ? SplashScreen(onFinish: () => setState(() => _splashCompleted = true))
          : authState.user == null
              ? const AuthScreen()
              : const HomeScreen(),
    );
  }
}
