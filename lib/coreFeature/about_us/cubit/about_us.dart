import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/support/cubit/support_state.dart';

class AboutUsCubit extends SafeCubit<SupportState> {
  AboutUsCubit() : super(SupportState());

  Future<void> getAboutUs() async {
    emit(state.copyWith(isLoading: true));
    final result = await DioService.instance.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.setting,
        method: .GET,
        queryParams: {"aboutUs": ''},
      ),
      responseBuilder: (data) => data,
    );
    emit(
      state.copyWith(
        isLoading: false,
        message: result.data?['aboutUs']?.toString() ?? '',
      ),
    );
  }
}
