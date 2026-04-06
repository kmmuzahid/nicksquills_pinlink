/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 15:57:37
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().init();
    });
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CommonImage(src: Assets.images.splash.path, fill: BoxFit.fill),
      ),
    );
  }
}
