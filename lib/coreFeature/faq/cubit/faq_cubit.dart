import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/coreFeature/faq/cubit/faq_state.dart';
import 'package:pinlink/coreFeature/faq/model/faq_model.dart';

class FaqCubit extends SafeCubit<FaqState> {
  FaqCubit() : super(const FaqState());

  Future<void> getFaqs({int page = 1, bool isRefresh = false}) async {
    emit(state.copyWith(isLoading: true, faqs: isRefresh ? [] : null));
    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.faq,
        method: .GET,
        queryParams: {"page": page, "limit": 30},
      ),
      responseBuilder: (data) =>
          List<FaqModel>.from(data.map((x) => FaqModel.fromJson(x))),
    );

    emit(
      state.copyWith(isLoading: false, faqs: [...state.faqs, ...?result.data]),
    );
  }
}
