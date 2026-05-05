import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_state.dart';
import 'package:pinlink/coreFeature/custom_google_map/widgets/map_search_bar.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({
    required this.widgets,
    super.key,
    this.headerAction,
    this.liteMode = true,
    this.enableReagionObserver = false,
  });
  final List<Widget> Function(BuildContext context, MapState state) widgets;
  final Widget? headerAction;
  final bool liteMode;
  final bool enableReagionObserver;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        final cubit = context.read<MapCubit>();
        return Stack(
          children: [
            GoogleMap(
              liteModeEnabled: liteMode,
              onTap: (coordinate) {
                cubit.setPoint(coordinate: coordinate);
              },
              // onCameraIdle: enableReagionObserver ? cubit.onCameraIdle : null,
              initialCameraPosition: CameraPosition(
                target: state.starting.coordinate,
                zoom: 20.0,
              ),
              markers: state.markers,
              polylines: state.mapRoute,
              onMapCreated: (cotroller) {
                context.read<MapCubit>().onMapCreated(cotroller);
              },
            ),
            Align(alignment: Alignment.topCenter, child: _header(cubit, state)),
            ...widgets(context, state),
            if (state.isLoading)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.white54,
                    border: Border.all(
                      width: 1.w,
                      color: context.colors.pRIMARY_brandClr,
                    ),
                  ),
                  child: CircularProgressIndicator(
                    color: context.colors.pRIMARY_brandClr,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _header(MapCubit cubit, MapState state) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: MapSearchBar(
      action: headerAction,
      icon: GestureDetector(
        onTap: () {
          cubit.setPointType(PointType.starting).then((_) {
            cubit.setCurrentPosition();
          });
        },
        child: Icon(
          Icons.place,
          color: state.lastPikedPointType == PointType.starting
              ? Colors.cyan
              : Colors.black45,
        ),
      ),
      initalAddress: state.starting.address,
      hints: 'Search Here',
      onSubmit: cubit.setCoordinateFromPlaceId,
      onTap: () {
        cubit.setPointType(PointType.starting);
      },
    ),
  );
}
