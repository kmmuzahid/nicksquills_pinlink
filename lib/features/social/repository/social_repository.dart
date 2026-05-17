import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/features/social/model/post_model.dart';

class SocialRepository {
  Future<ResponseState<List<PostModel>?>> getAllPost({
    required int page,
    String? searchText,
    String? type,
    bool userPostOnly = false,
  }) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: userPostOnly
            ? ApiEndPoint.instance.userPost
            : ApiEndPoint.instance.user,
        method: .GET,
        queryParams: {
          'page': page,
          if (searchText != null && searchText.isNotEmpty)
            'searchText': searchText,
          'limit': 10,
          'type': ?type,
        },
      ),
      responseBuilder: (data) {
        return List<PostModel>.from(data.map((x) => PostModel.fromJson(x)));
      },
    );
  }

  Future<ResponseState<dynamic>> sharePost(String postId) async {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.sharePost,
        method: .POST,
        jsonBody: {'postDataId': postId},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> createPostReport(
    String postId,
    String reportReason,
  ) async {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.createPostReport,
        method: .POST,
        jsonBody: {'postId': postId, 'text': reportReason},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> likePost(String postId) async {
    return DioService.instance.request(
      showMessage: false,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.likePost,
        method: .POST,
        jsonBody: {'postId': postId},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> follow(String userId) async {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.follow,
        method: .POST,
        jsonBody: {'followingId': userId},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<PostModel?>> getPostDetails(String postId) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.postDetails,
        method: .GET,
        pathParams: [postId],
      ),
      responseBuilder: (data) {
        return PostModel.fromJson(data);
      },
    );
  }
}
