/*
 * @Author: Km Muzahid
 * @Date: 2026-03-07 14:50:47
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:pinlink/coreFeature/custom_google_map/widgets/custom_google_map.dart';

@RoutePage()
class CustomMapScreen extends StatelessWidget {
  const CustomMapScreen({super.key, this.mapFilters});
  final MapFilters? mapFilters;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => MapCubit(enableFilter: mapFilters != null),
    child: LayoutBuilder(
      builder: (context, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CommonAppBar(
            title: mapFilters != null
                ? mapFilters!.displayName
                : 'Select Home Town',
            appbarConfig: AppbarConfig(
              actions: mapFilters == null
                  ? [
                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        onPressed: () {
                          appRouter.pop(
                            context.read<MapCubit>().state.starting,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 3,
                            bottom: 3,
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: context.colors.tEXT_white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [
                      // CubitScopeValue(
                      //   cubit: context.read<MapCubit>(),
                      //   builder: (contex, cubit, state) => CommonText(
                      //     text: 'Total: ${state.totalCourse}',
                      //     fontWeight: .bold,
                      //     fontSize: 18,
                      //     textColor: contex.colors.tEXT_white,
                      //   ),
                      // ),
                    ],
            ),
          ),
          body: CustomGoogleMap(
            filterPlayedModeOnlyEnabled: mapFilters != null,
            widgets: (contex, state) => [],
          ),
        );
      },
    ),
  );
}
