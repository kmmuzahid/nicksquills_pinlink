import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:pinlink/coreFeature/custom_google_map/widgets/custom_google_map.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit.dart';

class GolfMapScreen extends StatelessWidget {
  const GolfMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: BlocProvider(
        create: (context) => MapCubit(),
        child: CubitScope(
          create: () => GolfMapCubit(),
          builder: (context, cubit, state) {
            return CustomGoogleMap(
              enableSafeArea: false,
              filterGameChoiceEnabled: true,
              widgets: (contex, state) {
                return [];
              },
            );
          },
        ),
      ),
    );
  }
}
