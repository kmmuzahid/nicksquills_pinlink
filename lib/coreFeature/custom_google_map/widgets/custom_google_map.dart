import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/text_field/common_text_field.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_state.dart';
import 'package:pinlink/coreFeature/custom_google_map/widgets/map_search_bar.dart';
import 'package:pinlink/features/golf_map/widgets/filter_widget.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details_wishlish.dart';

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
    this.filterPlayedModeOnlyEnabled = false,
    this.filterGameChoiceEnabled = false,
    this.enableSafeArea = true,
  });
  final List<Widget> Function(BuildContext context, MapState state) widgets;
  final Widget? headerAction;
  final bool liteMode;
  final bool filterPlayedModeOnlyEnabled;
  final bool filterGameChoiceEnabled;
  final bool enableSafeArea;

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Offset? _clickPosition;

  @override
  void didUpdateWidget(CustomGoogleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filterPlayedModeOnlyEnabled || widget.filterGameChoiceEnabled) {
      context.read<MapCubit>().onCameraIdle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (previous, current) =>
          previous.selectedCourse.id != current.selectedCourse.id,
      listener: (context, state) async {
        if (state.selectedCourse.id?.isEmpty == true) {
          setState(() {
            _clickPosition = null;
          });
          return;
        }

        final cubit = context.read<MapCubit>();
        await Future.delayed(const Duration(milliseconds: 150));
        if (!mounted) return;

        final marker = state.markers.firstWhere(
          (m) => m.markerId.value == state.selectedCourse.id,
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
            state.selectedCourse.id?.isNotEmpty == true &&
            (widget.filterPlayedModeOnlyEnabled ||
                widget.filterGameChoiceEnabled);

        return LayoutBuilder(
          builder: (context, constraints) {
            final mapHeight = constraints.maxHeight;

            Widget? detailsCard;
            if (showDetails &&
                state.selectedCourse.id?.isNotEmpty == true &&
                _clickPosition != null) {
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
                    child: state.selectedFilter == MapFilters.Wishlist
                        ? MapPointsDetailsWishlish(
                            name: state.selectedCourse.name ?? '',
                            address: state.selectedCourse.locationName ?? '',
                            courseId: state.selectedCourse.id ?? '',
                            mapPointModel: state.selectedCourse,
                          )
                        : MapPointsDetails(
                            courseId: state.selectedCourse.id ?? '',
                          ),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                GoogleMap(
                  liteModeEnabled: widget.liteMode,
                  myLocationButtonEnabled: false,

                  onCameraMoveStarted: () {
                    cubit.clearSelectedCourse();
                  },

                  onTap: (coordinate) {
                    if (widget.filterPlayedModeOnlyEnabled ||
                        widget.filterGameChoiceEnabled) {
                      cubit.clearSelectedCourse();
                    } else {
                      cubit.setPoint(coordinate: coordinate);
                    }
                  },
                  onCameraIdle: () {
                    if ((widget.filterPlayedModeOnlyEnabled ||
                            widget.filterGameChoiceEnabled) &&
                        !state.isFirstTimeFetch) {
                      cubit.onCameraIdle();
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
                    context.read<MapCubit>().onMapCreated(cotroller);
                  },
                ),
                if (!(widget.filterGameChoiceEnabled ||
                    widget.filterPlayedModeOnlyEnabled))
                  Align(
                    alignment: Alignment.topCenter,
                    child: _header(cubit, state),
                  ),
                ...widget.widgets(context, state),

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
                if (widget.filterGameChoiceEnabled ||
                    widget.filterPlayedModeOnlyEnabled) ...[
                  Positioned(
                    bottom: 10 + (widget.enableSafeArea ? 25.h : 0),
                    left: 16,
                    child: SizedBox(
                      width: CoreScreenUtils.deviceSize.width * .7,
                      child: CommonTextField(
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.colors.tEXT_sub,
                        ),
                        validationType: .notRequired,
                        backgroundColor: context.colors.background,
                        hintText: 'Search courses on map...',
                      ),
                    ),
                  ),

                  Positioned(
                    right: 10,
                    bottom: 10 + (widget.enableSafeArea ? 25.h : 0),
                    child: _totalCourses(
                      context,
                      state.totalCourse,
                      state.isFirstTimeFetch,
                      getGolfPrimaryColor(state.selectedFilter),
                    ),
                  ),
                  if (widget.filterGameChoiceEnabled)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: context.colors.bACKGROUND_darkCard,
                        alignment: .center,
                        child: _buildFilterSection(
                          context,
                          state.selectedFilter,
                          cubit.changeFilter,
                        ),
                      ),
                    ),

                  ?detailsCard,
                ],
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    MapFilters? selectedFilter,
    Function(MapFilters) changeFilter,
  ) {
    return Wrap(
      spacing: 4.w,
      children: [
        FilterWidget(
          title: MapFilters.Played,
          selectedFilter: selectedFilter,
          subtitle: "Courses Done",
          iconData: Icons.place_outlined,
          onTap: changeFilter,
        ),
        FilterWidget(
          selectedFilter: selectedFilter,
          title: MapFilters.Wishlist,
          subtitle: "Saved courses",
          iconData: Icons.bookmark_border,
          onTap: changeFilter,
        ),
        FilterWidget(
          selectedFilter: selectedFilter,
          title: MapFilters.Friends,
          subtitle: "Friends’ activity",
          iconData: Icons.people,
          onTap: changeFilter,
        ),
        FilterWidget(
          selectedFilter: selectedFilter,
          title: MapFilters.PinLinks5,
          subtitle: "Top rated picks",
          iconData: Icons.emoji_events_outlined,
          onTap: changeFilter,
        ),
      ],
    );
  }

  Widget _totalCourses(
    BuildContext context,
    int count,
    bool isLoading,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: .4), width: 1.5),
      ),
      child: isLoading
          ? Padding(
              padding: EdgeInsets.all(18.w),
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                CommonText(
                  text: '$count',
                  fontSize: 24,
                  fontWeight: .w700,
                  textColor: color,
                ),
                CommonText(
                  text: 'Courses',
                  fontSize: 14,
                  fontWeight: .w400,
                  textColor: color,
                ),
              ],
            ),
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
