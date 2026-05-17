import 'package:equatable/equatable.dart';
import 'package:pinlink/features/golf_map/model/map_point_details_model.dart';

class MapPointDetailsState extends Equatable {
  final bool isLoading;
  final MapPointDetailsModel? mapPointsDetails;
  final List<MapEntry<DateTime, String>> links;

  const MapPointDetailsState({
    this.isLoading = false,
    this.mapPointsDetails,
    this.links = const [],
  });

  MapPointDetailsState copyWith({
    bool? isLoading,
    MapPointDetailsModel? mapPointsDetails,
    List<MapEntry<DateTime, String>>? links,
  }) => MapPointDetailsState(
    isLoading: isLoading ?? this.isLoading,
    mapPointsDetails: mapPointsDetails ?? this.mapPointsDetails,
    links: links ?? this.links,
  );

  @override
  List<Object?> get props => [isLoading, mapPointsDetails, links];
}
