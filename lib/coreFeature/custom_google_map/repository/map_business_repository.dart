import 'package:core_kit/core_kit_internal.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/custom_google_map/model/business_model/map_point_model.dart';
import 'package:pinlink/features/golf_map/model/map_point_details_model.dart';

class MapBusinessRepository {
  Future<ResponseState<MapEntry<int, List<MapPointModel>>?>> getCourseMap({
    required double topLat,
    required double bottomLat,
    required double leftLng,
    required double rightLng,
    String? searchQuery,
    required MapFilters mapFilters,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.courseMap,
        method: .GET,
        queryParams: {
          "type": mapFilters.value,
          "topLat": topLat,
          "bottomLat": bottomLat,
          "leftLng": leftLng,
          "rightLng": rightLng,
          "search": ?searchQuery,
        },
      ),
      responseBuilder: (data) {
        return MapEntry(
          data['totalCount']?.toInt() ?? 0,
          List<MapPointModel>.from(
            (data['result'] ?? []).map((x) => MapPointModel.fromJson(x)),
          ),
        );
      },
    );
  }

  Future<ResponseState<MapPointDetailsModel?>> getMapPointDetails(
    String courseId,
  ) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.coursePost,
        method: .GET,
        queryParams: {"courseId": courseId},
      ),
      responseBuilder: (data) {
        return MapPointDetailsModel.fromJson(data);
      },
    );
  }
}
