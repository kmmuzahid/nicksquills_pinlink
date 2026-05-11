import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';

class CourseRepository {
  Future<ResponseState<List<UserCourseModel>?>> getUserPlayedCourse({
    String? query,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.userPlayedCourse,
        method: .GET,
        queryParams: {'searchText': query},
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => UserCourseModel.fromJson(e)).toList();
      },
    );
  }
}
