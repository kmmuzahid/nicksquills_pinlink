class SupportState {
  final bool isLoading;
  final String? message;

  SupportState({this.isLoading = false, this.message});

  SupportState copyWith({bool? isLoading, String? message}) {
    return SupportState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}
