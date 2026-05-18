import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_state.dart';
import 'package:pinlink/coreFeature/custom_google_map/widgets/map_search_bar.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details.dart';

const String mapStyle = '''
[
  {
    "featureType": "poi",
    "stylers": [
      { "visibility": "off" }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels",
    "stylers": [
      { "visibility": "off" }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      { "visibility": "off" }
    ]
  }
]
''';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({
    required this.widgets,
    super.key,
    this.headerAction,
    this.liteMode = true,
    this.mapFilters,
  });
  final List<Widget> Function(BuildContext context, MapState state) widgets;
  final Widget? headerAction;
  final bool liteMode;
  final MapFilters? mapFilters;

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Offset? _clickPosition;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.courseId != current.courseId,
      listener: (context, state) async {
        if (state.courseId.isEmpty) {
          setState(() {
            _clickPosition = null;
          });
          return;
        }

        final cubit = context.read<MapCubit>();
        await Future.delayed(const Duration(milliseconds: 150));
        if (!mounted) return;

        final marker = state.markers.firstWhere(
          (m) => m.markerId.value == state.courseId,
          orElse: () => const Marker(markerId: MarkerId('')),
        );

        if (marker.markerId.value.isNotEmpty) {
          try {
            final screenCoordinate = await cubit.mapController
                .getScreenCoordinate(marker.position);
            if (mounted) {
              setState(() {
                _clickPosition = Offset(
                  screenCoordinate.x.toDouble(),
                  screenCoordinate.y.toDouble(),
                );
              });
            }
          } catch (e) {
            debugPrint('Error getting screen coordinate: $e');
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<MapCubit>();
        final showDetails =
            state.courseId.isNotEmpty &&
            widget.mapFilters != null &&
            widget.mapFilters != MapFilters.Wishlist;

        return LayoutBuilder(
          builder: (context, constraints) {
            final mapHeight = constraints.maxHeight;

            Widget? detailsCard;
            if (showDetails && _clickPosition != null) {
              final isBottomHalf = _clickPosition!.dy > mapHeight / 2;
              detailsCard = Positioned(
                top: isBottomHalf ? null : _clickPosition!.dy,
                bottom: isBottomHalf ? (mapHeight - _clickPosition!.dy) : null,
                left: 0,
                right: 0,
                child: Align(
                  alignment: isBottomHalf
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: MapPointsDetails(courseId: state.courseId),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                GoogleMap(
                  liteModeEnabled: widget.liteMode,
                  onTap: (coordinate) {
                    if (widget.mapFilters != null) {
                      cubit.clearCourseId();
                    } else {
                      cubit.setPoint(coordinate: coordinate);
                    }
                  },
                  onCameraIdle: () {
                    if (widget.mapFilters != null) {
                      cubit.onCameraIdle(widget.mapFilters!);
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: state.starting.coordinate,
                    zoom: 20.0,
                  ),
                  markers: state.markers,
                  style: mapStyle,
                  polylines: state.mapRoute,
                  onMapCreated: (cotroller) {
                    context.read<MapCubit>().onMapCreated(
                      cotroller,
                      mapFilters: widget.mapFilters,
                    );
                  },
                ),
                if (widget.mapFilters == null)
                  Align(
                    alignment: Alignment.topCenter,
                    child: _header(cubit, state),
                  ),
                ...widget.widgets(context, state),
                if (detailsCard != null) detailsCard,
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
      },
    );
  }

  Widget _header(MapCubit cubit, MapState state) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: MapSearchBar(
      action: widget.headerAction,
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
