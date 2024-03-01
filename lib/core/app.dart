import 'package:crimson_cycle/config/router/app_routes.dart';
import 'package:crimson_cycle/config/themes/app_theme.dart';
import 'package:crimson_cycle/core/common/provider/dark_theme.dart';
import 'package:crimson_cycle/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      theme: AppTheme.getApplicationTheme(isDarkTheme),
      debugShowCheckedModeBanner: false,
      home: const DashboardView(),
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
