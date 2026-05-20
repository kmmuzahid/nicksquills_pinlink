import 'package:equatable/equatable.dart';
import 'package:pinlink/coreFeature/faq/model/faq_model.dart';

class FaqState extends Equatable {
  final List<FaqModel> faqs;
  final bool isLoading;
  final String? error;

  const FaqState({this.faqs = const [], this.isLoading = false, this.error});

  FaqState copyWith({List<FaqModel>? faqs, bool? isLoading, String? error}) =>
      FaqState(
        faqs: faqs ?? this.faqs,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [faqs];
}
