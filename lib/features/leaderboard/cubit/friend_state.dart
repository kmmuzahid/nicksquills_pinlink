import 'package:equatable/equatable.dart';
import 'package:pinlink/features/leaderboard/model/friend_model.dart';

class FriendState extends Equatable {
  final bool isFrendListLoading;
  final bool isFrendRequestSending;
  final List<FriendModel> frendList;
  final List<FriendModel> selectedFriends;

  const FriendState({
    this.isFrendListLoading = false,
    this.isFrendRequestSending = false,
    this.frendList = const [],
    this.selectedFriends = const [],
  });

  FriendState copyWith({
    bool? isFrendListLoading,
    bool? isFrendRequestSending,
    List<FriendModel>? frendList,
    List<FriendModel>? selectedFriends,
  }) {
    return FriendState(
      isFrendListLoading: isFrendListLoading ?? this.isFrendListLoading,
      isFrendRequestSending:
          isFrendRequestSending ?? this.isFrendRequestSending,
      frendList: frendList ?? this.frendList,
      selectedFriends: selectedFriends ?? this.selectedFriends,
    );
  }

  @override
  List<Object?> get props => [
    isFrendListLoading,
    isFrendRequestSending,
    frendList,
    selectedFriends,
  ];
}
