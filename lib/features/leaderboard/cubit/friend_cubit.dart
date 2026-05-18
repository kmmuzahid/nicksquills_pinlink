import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/leaderboard/cubit/friend_state.dart';
import 'package:pinlink/features/leaderboard/model/friend_model.dart';

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

  final deboucer = Debouncer(milliseconds: 500);
  String? searchQuery;

  Future<void> search(String search) async {
    deboucer.run(() async {
      searchQuery = search.isEmpty ? null : search;
      getAllFrendList(isRefresh: true);
    });
  }

  Future<void> getAllFrendList({int page = 1, bool isRefresh = false}) async {
    if (state.isFrendListLoading) return;
    emit(
      state.copyWith(
        isFrendListLoading: true,
        frendList: isRefresh ? [] : null,
      ),
    );

    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.allFriends,
        method: .GET,
        queryParams: {'page': page, 'limit': 10, 'searchText': ?searchQuery},
      ),
      responseBuilder: (data) {
        return List.from(data?.map((x) => FriendModel.fromJson(x)));
      },
    );

    emit(
      state.copyWith(
        isFrendListLoading: false,
        frendList: [...state.frendList, ...(result.data ?? [])],
      ),
    );
  }

  void toggleFriendSelection(FriendModel friend) {
    final selectedFriends = List<FriendModel>.from(state.selectedFriends);
    final index = selectedFriends.indexWhere((e) => e.id == friend.id);
    if (index >= 0) {
      selectedFriends.removeAt(index);
    } else {
      selectedFriends.add(friend);
    }
    emit(state.copyWith(selectedFriends: selectedFriends));
  }
}
