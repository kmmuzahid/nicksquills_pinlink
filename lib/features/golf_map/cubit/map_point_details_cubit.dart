import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/coreFeature/custom_google_map/repository/map_business_repository.dart';
import 'package:pinlink/features/golf_map/cubit/map_point_details_state.dart';

class MapPointDetailsCubit extends SafeCubit<MapPointDetailsState> {
  MapPointDetailsCubit() : super(const MapPointDetailsState());

  final MapBusinessRepository mapBusinessRepository = getIt();

  Future<void> getMapPointDetails(String courseId) async {
    emit(state.copyWith(isLoading: true));
    final result = await mapBusinessRepository.getMapPointDetails(courseId);
    final links = <MapEntry<DateTime, String>>[];
    result.data?.allPost?.forEach((e) {
      final createdAt = e?.postDataId?.createdAt;
      final dateTime = createdAt != null
          ? DateTime.tryParse(createdAt) ?? DateTime.now()
          : DateTime.now();
      e?.postDataId?.links?.forEach((link) {
        if (link != null && link.isNotEmpty) {
          links.add(MapEntry(dateTime, link));
        }
      });
    });
    emit(
      state.copyWith(
        isLoading: false,
        mapPointsDetails: result.data,
        links: links,
      ),
    );
  }
}
