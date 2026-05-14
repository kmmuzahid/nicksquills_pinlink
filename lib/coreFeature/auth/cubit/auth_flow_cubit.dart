import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_state.dart';
import 'package:pinlink/coreFeature/auth/entity/forget_pass_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/login_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/repository/auth_repository.dart';
import 'package:pinlink/features/course_comparision/model/global_course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/course_comparision/utils/course_search_overlay_manager.dart';

class AuthFlowCubit extends SafeCubit<AuthFlowState> {
  AuthFlowCubit(this.authCubit) : super(const AuthFlowState());
  final AuthCubit authCubit;
  final AuthRepository _authRepository = AuthRepository();
  final _courseRepository = getIt<CourseRepository>();
  final _debounce = Debouncer(milliseconds: 300);

  Future<void> login(LoginEntity entity) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.login(entity);
    emit(state.copyWith(isLoading: false));
    if (result.isSuccess) {
      await authCubit.updateTokens(
        result.data?['accessToken'] ?? '',
        result.data?['refreshToken'] ?? '',
      );
      appRouter.replaceAll([const NavigationRoute()]);
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
      if (result.statusCode == 424) {
        appRouter.push(
          SendOtpRoute(
            onSuccess: ({required email, required token}) async {
              final loginEntity = LoginEntity();
              loginEntity.email = email;
              loginEntity.password = entity.password;
              login(loginEntity);
            },
            token: result.data?['token']?.toString() ?? '',
            username: entity.email!,
            showSendToField: true,
          ),
        );
      }
    }
  }

  Future<void> signup(SignUpEntity entity) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.signup(entity);
    emit(state.copyWith(isLoading: false));
    if (result.isSuccess) {
      emit(const AuthFlowState());
      appRouter.push(
        SendOtpRoute(
          token: result.data?['createUserToken']?.toString(),
          onSuccess: ({required email, required token}) async {
            final loginEntity = LoginEntity();
            loginEntity.email = email;
            loginEntity.password = entity.password;
            login(loginEntity);
          },
          username: entity.email!,
          showSendToField: true,
        ),
      );
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
    }
  }

  Future<void> resetPassword(ForgetPassEntity entity) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.resetPassword(entity);
    emit(state.copyWith(isLoading: false));
    if (result.isSuccess) {
      appRouter.replaceAll([const LoginRoute()]);
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
    }
  }

  final Debouncer debouncer = Debouncer(milliseconds: 300);

  Future<void> searchCourses(String query) async {
    if (query == '') {
      hideOverlay();
      return;
    }
    debouncer.run(() {
      emit(state.copyWith(searchText: query));
      if (query.isEmpty) {
        emit(state.copyWith(searchResults: [], isSearching: false));
        return;
      }

      emit(state.copyWith(isSearching: true));

      _debounce.run(() async {
        final result = await _courseRepository.getGlobalCourses(
          query: query,
          retry: 0,
        );
        if (result.isSuccess) {
          emit(
            state.copyWith(
              searchResults: result.data ?? [],
              isSearching: false,
            ),
          );
        } else {
          emit(state.copyWith(searchResults: [], isSearching: false));
        }
      });
    });
  }

  LayerLink layerLink = LayerLink();
  CourseSearchOverlayManager? overlayManager;

  void initOverlay(FocusNode focusNode) {
    overlayManager ??= CourseSearchOverlayManager(focusNode, layerLink);
  }

  void selectCourse(GlobalCourseModel course) {
    overlayManager?.hideOverlay();
    emit(
      state.copyWith(selectedCourse: course, searchResults: [], searchText: ''),
    );
  }

  void removeSelectedCourse() {
    emit(state.copyWith(clearSelectedCourse: true));
  }

  void hideOverlay() => overlayManager?.hideOverlay();

  void showOverlay(
    BuildContext context,
    List<GlobalCourseModel> results,
    bool isSearching,
  ) {
    overlayManager?.showOverlay(
      context: context,
      results: results,
      isSearching: isSearching,
      searchText: state.searchText,
      onCourseSelected: selectCourse,
    );
  }

  void clearSearchResults() {
    emit(state.copyWith(searchResults: [], isSearching: false));
  }

  @override
  Future<void> close() {
    overlayManager?.dispose();
    return super.close();
  }
}
