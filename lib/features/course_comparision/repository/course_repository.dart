import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';

class CourseRepository {
  Future<ResponseState<List<UserCourseModel>?>> getUserPlayedCourse({
    String? query,
    int page = 1,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.userPlayedCourse,
        method: .GET,
        queryParams: {
          'searchText': ?query,
          'page': page,
          'limit': 10,
          'sort': 'rank',
        },
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => UserCourseModel.fromJson(e)).toList();
      },
    );
  }

  Future<ResponseState<List<CourseModel>?>> getUserAvailableCourse({
    String? query,
    int page = 1,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.courseUser,
        method: .GET,
        queryParams: {
          'searchText': ?query,
          'page': page,
          'limit': 10,
          'sort': 'rank',
        },
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => CourseModel.fromJson(e)).toList();
      },
    );
  }

  Future<ResponseState<List<CourseModel>?>> getGlobalCourses({
    String? query,
    int retry = 3,
  }) async {
    return DioService.instance.request(
      maxRetry: retry,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.coursePublic,
        method: .GET,
        queryParams: {'searchTerm': ?query},
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => CourseModel.fromJson(e)).toList();
      },
    );
  }

  Future<ResponseState<List<UserCourseModel>?>> getUserWishlistCourse({
    required int page,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.wishlistCourse,
        method: .GET,
        queryParams: {'page': page, 'limit': 10, 'sort': 'rank'},
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => UserCourseModel.fromJson(e)).toList();
      },
    );
  }

  Future<void> reorderRank({
    required int requestedRank,
    required List<UserCourseModel> courses,
  }) async {
    if (courses.isEmpty) return;
    double top = 0;
    double bottom = 0;

    if (requestedRank == 0) {
      bottom = courses.first.customRank!;
    } else if (requestedRank == courses.length) {
      top = courses[requestedRank - 1].customRank!;
      bottom = top + 1000;
    } else {
      top = courses[requestedRank - 1].customRank!;
      bottom = courses[requestedRank + 1].customRank!;
    }

    final updatedRank = (top + bottom) / 2;

    print(updatedRank);
  }

  Future<ResponseState<List<UserCourseModel>?>> rankData({
    required List<int> rank,
    required bool isWishListRank,
    bool shortByRank = true,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.rankData,
        method: .GET,
        jsonBody: {
          "type": isWishListRank ? "wishlistCourseRank" : "compareCourseRank",
          "rank": rank,
          "sortBy": shortByRank ? "rank" : "customRank",
        },
      ),

      responseBuilder: (data) {
        return List.from(data).map((e) => UserCourseModel.fromJson(e)).toList();
      },
    );
  }

  Future<ResponseState<dynamic>> saveRank({
    required List<UserCourseModel> courses,
    required bool isWishListRank,
  }) async {
    final listBody = <Map<String, dynamic>>[
      for (var course in courses) ...{
        {
          "courseId": course.courseId?.id,
          "rank": course.customRank,
          "favorite": course.favorite,
          "scenery": course.scenery,
          "difficulty": course.difficulty,
          "teeBoxFairwayCondition": course.teeBoxFairwayCondition,
          "greenSpeed": course.greenSpeed,
          "greenCondition": course.greenCondition,
          "clubHouse": course.clubHouse,
          "foodDrink": course.foodDrink,
        },
      },
    ];
    return DioService.instance.request(
      input: RequestInput(
        endpoint: isWishListRank
            ? ApiEndPoint.instance.createWishlistCourse
            : ApiEndPoint.instance.createCompareCourse,
        method: .POST,
        listBody: listBody,
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> reorderCompareCourses({
    required String compareCourseId,
    required double rank,
    required bool isRevert,
  }) async {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.reorderRank,
        method: .POST,
        jsonBody: {
          "type": isRevert ? "revert" : "create",
          "compareCourseId": compareCourseId,
          "rank": rank,
        },
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }
}
