import 'package:equatable/equatable.dart';
import 'package:pinlink/features/course_comparision/model/global_course_model.dart';

class AuthFlowState extends Equatable {
  final bool isLoading;
  final bool isSearching;
  final List<GlobalCourseModel> searchResults;
  final String? errorMessage;

  final GlobalCourseModel? selectedCourse;

  final String searchText;

  const AuthFlowState({
    this.isLoading = false,
    this.isSearching = false,
    this.searchResults = const [],
    this.errorMessage,
    this.selectedCourse,
    this.searchText = '',
  });

  AuthFlowState copyWith({
    bool? isLoading,
    bool? isSearching,
    List<GlobalCourseModel>? searchResults,
    String? errorMessage,
    GlobalCourseModel? selectedCourse,
    bool clearSelectedCourse = false,
    String? searchText,
  }) {
    return AuthFlowState(
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCourse:
          clearSelectedCourse ? null : selectedCourse ?? this.selectedCourse,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSearching,
    searchResults,
    errorMessage,
    selectedCourse,
    searchText,
  ];
}
