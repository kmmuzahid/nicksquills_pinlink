/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 12:06:19
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/storage/storage_key.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/gen/assets.gen.dart';


class CoreKitConfigImpl extends CoreKitConfig with CoreKitConfigDefaults {  

  @override
  String get imageBaseUrl => ApiEndPoint.instance.domain;

  @override
  DioServiceConfig get dioConfig {
    return DioServiceConfig(
      baseUrl: ApiEndPoint.instance.baseUrl,
      refreshTokenEndpoint: ApiEndPoint.instance.refreshTokenEndpoint,
      onLogout: () {
        context.read<AuthCubit>().clearTokens();
      },
      enableDebugLogs: true,
    );
  }

  @override
  TokenProvider get tokenProvider {
    return TokenProvider(
      accessToken: () async => (await StorageService.instance.accessToken) ?? '',
      refreshToken: () async {
        AppLogger.debug(
          (await StorageService.instance.refreshToken).toString(),
          tag: 'refreshToken',
        );
        return (await StorageService.instance.refreshToken) ?? '';
      },
      updateTokens: (data) async {
        AppLogger.debug('Update Tokens', tag: 'updateTokens');
        await context.read<AuthCubit>().updateTokens(data['accessToken'], data['refreshToken']);
      },
    );
  }

  @override
  AppbarConfig? get appbarConfig {
    return AppbarConfig(
      titleColor: () => context.colors.tEXT_white,
      titleAlignment: .center,
      decoration: () => BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.bACKGROUND_darkCardBoarder, width: 1.5),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.transparent,
      ),
      onBack: () {
        appRouter.pop();
      },

      actions: [
        // Builder(
        //   builder: (context) {
        //     return IconButton(
        //       onPressed: () {
        //         context.read<ThemeCubit>().toggleTheme();
        //       },
        //       icon: Icon(Icons.track_changes, color: context.colors.tEXT_white),
        //     );
        //   },
        // ),
      ],

      backButton: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
            color: Colors.transparent,
            child: CommonImage(
              size: 18.w,
              src: Assets.images.back,
              imageColor: context.colors.tEXT_white,
              fill: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
