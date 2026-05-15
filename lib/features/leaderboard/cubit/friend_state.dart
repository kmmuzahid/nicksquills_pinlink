import 'package:equatable/equatable.dart';

class FriendState extends Equatable {
  final bool isFrendListLoading;
  final bool isFrendRequestSending;

  const FriendState({
    this.isFrendListLoading = false,
    this.isFrendRequestSending = false,
  });

  FriendState copyWith({
    bool? isFrendListLoading,
    bool? isFrendRequestSending,
  }) {
    return FriendState(
      isFrendListLoading: isFrendListLoading ?? this.isFrendListLoading,
      isFrendRequestSending:
          isFrendRequestSending ?? this.isFrendRequestSending,
    );
  }

  @override
  List<Object?> get props => [isFrendListLoading, isFrendRequestSending];
}
