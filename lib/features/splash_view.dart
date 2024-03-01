import 'package:crimson_cycle/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  late SplashViewModel splashViewModel;

  @override
  void initState() {
    splashViewModel = ref.read(splashViewModelProvider.notifier);

    splashViewModel.splashNavigator.context = context;
    Future.delayed(const Duration(seconds: 5), () {
      ref.read(splashViewModelProvider.notifier).init(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 400, child: Lottie.asset("assets/splash_animation.json")),
          const Text(
            "CrimsonCycle",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
