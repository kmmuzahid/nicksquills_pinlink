import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/leaderboard/cubit/friend_state.dart';

class FriendCubit extends SafeCubit<FriendState> {
  FriendCubit() : super(const FriendState());

  Future<void> addFriend(String username) async {
    if (state.isFrendRequestSending) return;
    emit(state.copyWith(isFrendRequestSending: true));

    await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.createFriend,
        method: .POST,
        jsonBody: {'userNameEmail': username},
      ),
      responseBuilder: (data) {
        return data;
      },
    );

    emit(state.copyWith(isFrendRequestSending: false));
  }
}
