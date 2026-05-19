import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/features/support/cubit/support_state.dart';

class SupportCubit extends SafeCubit<SupportState> {
  SupportCubit() : super(SupportState());

  Future<void> submitToSupport({
    required String title,
    required String description,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.support,
        method: .POST,
        jsonBody: {'title': title, 'message': description},
      ),
      responseBuilder: (data) => data,
    );
    emit(state.copyWith(isLoading: false));
    if (result.isSuccess) {
      appRouter.pop();
    }
  }
}
