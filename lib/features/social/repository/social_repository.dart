import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/features/social/model/post_model.dart';

abstract class SocialBase {
  Future<ResponseState<List<PostModel>?>> getAllPost(
    int page,
    String? searchText,
    String? type,
  );
}

class SocialRepository extends SocialBase {
  @override
  Future<ResponseState<List<PostModel>?>> getAllPost(
    int page,
    String? searchText,
    String? type,
  ) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.user,
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
}
