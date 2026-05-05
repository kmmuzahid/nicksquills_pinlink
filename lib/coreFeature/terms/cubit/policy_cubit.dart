import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/coreFeature/terms/cubit/policy_state.dart';

class PolicyCubit extends SafeCubit<PolicyState> {
  PolicyCubit() : super(const PolicyState());

  Future<void> fetchPolicy() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.setting,
        method: .GET,
        queryParams: {'privacyPolicy': 'privacyPolicy'},
      ),
      responseBuilder: (data) {
        return data['privacyPolicy']?.toString();
      },
    );
    if (response.isSuccess) {
      emit(state.copyWith(privacyPolicy: response.data ?? ''));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchTermsAndConditions() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.setting,
        method: .GET,
        queryParams: {'termsOfService': 'termsOfService'},
      ),
      responseBuilder: (data) {
        return data['termsOfService']?.toString();
      },
    );
    if (response.isSuccess) {
      emit(state.copyWith(termsAndConditions: response.data ?? ''));
    }
    emit(state.copyWith(isLoading: false));
  }
}
