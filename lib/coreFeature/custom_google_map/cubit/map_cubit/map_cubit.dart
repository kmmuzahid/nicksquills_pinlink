import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_cubit/map_state.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/use_case/location_initialize_use_case.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/use_case/map_rendering_use_case.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/use_case/marker_creation_use_case.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/use_case/place_details_use_case.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/use_case/polyline_use_case.dart';
import 'package:pinlink/coreFeature/custom_google_map/model/business_model/map_point_model.dart';
import 'package:pinlink/coreFeature/custom_google_map/model/place_details.dart';
import 'package:pinlink/coreFeature/custom_google_map/repository/map_business_repository.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';
import 'package:pinlink/gen/assets.gen.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapCubit extends SafeCubit<MapState> {
  MapCubit({this.enableFilter = false})
    : locationInitUseCase = const LocationInitializationUseCase('last_gps'),
      markerCreationUseCase = MarkerCreationUseCase(),
      polylineUseCase = const PolylineUseCase(),
      placeDetailsUseCase = PlaceDetailsUseCase(),
      super(MapState.initial());
  final LocationInitializationUseCase locationInitUseCase;
  final MarkerCreationUseCase markerCreationUseCase;
  final PolylineUseCase polylineUseCase;
  final PlaceDetailsUseCase placeDetailsUseCase;
  late MapRenderingUseCase mapRenderingUseCase;
  late GoogleMapController mapController;
  final bool enableFilter;

  void onTravelModeChange(TravelMode mode) {
    emit(state.copyWith(travelMode: mode));

    if (state.destination != null) {
      getPolylinePoints(
        state.starting.coordinate,
        state.destination!.coordinate,
      );
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    mapController = controller;
    mapRenderingUseCase = MapRenderingUseCase(mapController);
    final permitted = await locationInitUseCase.checkPermission();

    if (!permitted) {
      AppLogger.error('Permission is not granted', tag: 'Map Cubit');
      emit(state.copyWith(initializing: false, isLoading: false));
      return;
    }

    final lastPosition = await locationInitUseCase.loadLastLocation();
    if (lastPosition != null) {
      await setPoint(
        coordinate: LatLng(lastPosition.latitude, lastPosition.longitude),
      );
    }

    await setCurrentPosition();
    emit(state.copyWith(initializing: false, isLoading: false));
    //app logic
    if (enableFilter) onCameraIdle();
  }

  Future<void> setCurrentPosition() async {
    try {
      final position = await locationInitUseCase.getCurrentPositionFast();
      if (position == null) {
        emit(state.copyWith(initializing: false));
        return;
      }

      final startLocation = LatLng(position.latitude, position.longitude);
      await locationInitUseCase.savePosition(position);

      setPointType(PointType.starting);

      await setPoint(coordinate: startLocation);
    } catch (e) {
      emit(state.copyWith(initializing: false));
      AppLogger.error('Error initializing map: $e', tag: 'Map Cubit');
    }
  }

  Future<void> getPolylinePoints(LatLng start, LatLng end) async {
    if (state.destination == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    try {
      final responce = await polylineUseCase.getRouteBetweenPoints(
        start,
        end,
        state.travelMode,
      );
      final points = polylineUseCase.getPoints(responce.primaryRoute);
      emit(state.copyWith(isLoading: false));

      AppLogger.debug(points?.length.toString() ?? 'dddd', tag: 'map');

      if (points?.isNotEmpty == true) {
        await mapRenderingUseCase.drawPolyline(points!, (polylines) {
          emit(state.copyWith(mapRoute: polylines));
        });
        final midPoint = points[(points.length / 2).toInt()];

        final distanceMeters = polylineUseCase.calculateDistance(
          responce.primaryRoute,
        );
        final durationSeconds = polylineUseCase.calculateDuration(
          responce.primaryRoute,
        );
        final distanceText = distanceMeters < 1000
            ? '$distanceMeters m'
            : '${(distanceMeters / 1000).toStringAsFixed(2)} km';
        final durationMinutes = durationSeconds / 60;
        final durationText = durationMinutes < 59
            ? '${CoreUtils.formatDouble(durationMinutes)} minutes'
            : '${CoreUtils.formatDouble(durationMinutes / 60)} hours';
        mapRenderingUseCase.addMarkers(
          start,
          end,
          midPoint,
          distanceText,
          durationText,
          (markers) => emit(state.copyWith(markers: markers)),
          markerCreationUseCase.createCustomMarker,
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      AppLogger.error(e.toString(), tag: 'Map Polyline Error');
    }
  }

  Future<void> onPointTypeChange(PointType pointType) async {
    final updatedMarkers = Set<Marker>.from(state.markers);
    updatedMarkers.removeWhere(
      (element) => element.markerId.value == pointType.name,
    );

    emit(
      state.copyWith(lastPikedPointType: pointType, markers: updatedMarkers),
    );
  }

  Future<void> setPointType(PointType pointType) async {
    emit(state.copyWith(lastPikedPointType: pointType));
    AppLogger.debug(pointType.name);
  }

  Future<void> setPoint({required LatLng coordinate}) async {
    PlaceDetails? details;
    try {
      details = await placeDetailsUseCase.getPlaceDetails(
        coordinate.latitude,
        coordinate.longitude,
      );
    } catch (e) {
      AppLogger.error('Reverse geocode failed: $e', tag: 'Map Cubit');
    }

    // Fallback to minimal place details if reverse geocode failed
    details ??= PlaceDetails(address: 'Unknown place', coordinate: coordinate);

    if (state.lastPikedPointType == PointType.starting) {
      final startMarker = await markerCreationUseCase.createStartMarker(
        coordinate,
      );
      final updatedMarkers = Set<Marker>.from(state.markers)
        ..removeWhere(
          (m) => m.markerId.value == 'starting' || m.markerId.value == 'middle',
        )
        ..add(startMarker);

      // Clear existing polyline when starting changes; it will be redrawn if destination exists
      emit(
        state.copyWith(
          starting: details,
          markers: updatedMarkers,
          mapRoute: {},
          selectedCourse: MapPointModel(),
        ),
      );

      if (state.destination != null) {
        await getPolylinePoints(coordinate, state.destination!.coordinate);
      } else {
        // Move camera to the single marker to make selection visible
        if (!isClosed) {
          await mapController.animateCamera(
            CameraUpdate.newLatLngZoom(coordinate, 15),
          );
        }
      }
    } else if (state.lastPikedPointType == PointType.destination) {
      final destMarker = await markerCreationUseCase.createDestinationMarker(
        coordinate,
      );
      final updatedMarkers = Set<Marker>.from(state.markers)
        ..removeWhere(
          (m) =>
              m.markerId.value == 'destination' || m.markerId.value == 'middle',
        )
        ..add(destMarker);

      emit(state.copyWith(destination: details, markers: updatedMarkers));

      // Draw the route from current starting to the new destination
      await getPolylinePoints(state.starting.coordinate, coordinate);
    }
  }

  Future<void> setCoordinateFromPlaceId({
    required String placeId,
    required String address,
  }) async {
    final placeDetails = await placeDetailsUseCase.getPlaceDetailsFromPlaceId(
      placeId,
      address,
    );
    if (placeDetails == null) return;

    if (state.lastPikedPointType == PointType.starting) {
      emit(state.copyWith(starting: placeDetails));
    } else if (state.lastPikedPointType == PointType.destination) {
      emit(state.copyWith(destination: placeDetails));
    }

    await setPoint(coordinate: placeDetails.coordinate);
  }

  void clearSelectedCourse() {
    _ignoreCameraIdle = false;
    emit(state.copyWith(selectedCourse: MapPointModel()));
  }

  // app based
  bool _isLoading = false;
  bool _ignoreCameraIdle = false;
  final _mapBusinessRepository = getIt<MapBusinessRepository>();
  CancelToken? _cancelToken;

  Future<void> onCameraIdle({bool isFirstLoad = false}) async {
    if (_isLoading ||
        state.initializing ||
        _ignoreCameraIdle ||
        state.isFirstTimeFetch) {
      return;
    }
    _isLoading = true;
    if (isFirstLoad) {
      emit(state.copyWith(isInitalLoading: true, markers: {}, mapRoute: {}));
    }

    try {
      _cancelToken?.cancel();
      _cancelToken = CancelToken();
      final bounds = await mapController.getVisibleRegion();

      final result = await _mapBusinessRepository.getCourseMap(
        topLat: bounds.northeast.latitude,
        bottomLat: bounds.southwest.latitude,
        leftLng: bounds.southwest.longitude,
        rightLng: bounds.northeast.longitude,
        mapFilters: state.selectedFilter,
        cancelToken: _cancelToken!,
      );
      _cancelToken = null;
      _isLoading = false;
      if (isFirstLoad) emit(state.copyWith(isInitalLoading: false));

      if (result.isSuccess && result.data?.value != null) {
        final dataList = result.data?.value as List<MapPointModel>;
        emit(state.copyWith(totalCourse: result.data?.key ?? 0));

        // Function to build marker for a parking point
        Future<Marker> buildMarker(MapPointModel data) async {
          final bitmap = await markerWidget(
            state.selectedFilter,
          ).toBitmapDescriptor();

          final position = LatLng(data.latitude!, data.longitude!);

          return Marker(
            markerId: MarkerId(data.id.toString()),
            position: position,
            icon: bitmap,
            consumeTapEvents: true,
            onTap: () async {
              _ignoreCameraIdle = true;
              emit(state.copyWith(selectedCourse: MapPointModel()));
              await Future.delayed(const Duration(milliseconds: 100));
              emit(state.copyWith(selectedCourse: data));
            },
          );
        }

        // Build all parking markers in parallel
        final markerFutures = dataList.map(buildMarker).toList();

        // Also fetch current location in parallel
        final results = await Future.wait([
          Future.wait(markerFutures),
          locationInitUseCase.getCurrentPositionFast(),
        ]);

        final markers = results[0] as List<Marker>;
        final location = results[1] as Position?;

        // Add GPS marker if available
        if (location != null) {
          final gpsMarker = Marker(
            markerId: const MarkerId('gps'),
            position: LatLng(location.latitude, location.longitude),
            icon: await const Icon(
              Icons.my_location,
              color: Colors.blue,
            ).toBitmapDescriptor(),
          );
          markers.add(gpsMarker);
        }

        emit(state.copyWith(markers: markers.toSet()));
      }
    } catch (e, st) {
      debugPrint('Error in onCameraIdle: $e\n$st');
    } finally {
      _isLoading = false;
      _cancelToken = null;
      emit(state.copyWith(isInitalLoading: false));
    }
  }

  Widget markerWidget(MapFilters selectedFilter) {
    final color = getGolfPrimaryColor(selectedFilter);
    return CommonImage(
      src: Assets.images.marker,
      width: 24.w,
      height: 35.h,
      imageColor: color,
    );
  }

  Future<void> changeFilter(MapFilters selectedFilter) async {
    _ignoreCameraIdle = false;
    emit(
      state.copyWith(
        selectedFilter: selectedFilter,
        totalCourse: 0,
        selectedCourse: MapPointModel(),
        isInitalLoading: false,
      ),
    );
    onCameraIdle(isFirstLoad: true);
  }
}
