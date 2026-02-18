import 'dart:convert';

class FaqModel {
  final String question;
  final String answer;

  const FaqModel({required this.question, required this.answer});

  //empty model
  factory FaqModel.empty() => const FaqModel(question: '', answer: '');

  /// Create an InfoModel from a Map (decoded JSON)
  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      question: map['question']?.toString() ?? '',
      answer: map['answer']?.toString() ?? '',
    );
  }

  /// Convert the InfoModel to a Map (for encoding to JSON)
  Map<String, dynamic> toMap() {
    return {'question': question, 'answer': answer};
  }

  /// Create from a JSON string
  factory FaqModel.fromJson(String source) => FaqModel.fromMap(json.decode(source));

  /// Convert to JSON string
  String toJson() => json.encode(toMap());

  /// Creates a copy with optional changed fields
  FaqModel copyWith({
    String? type,
    String? title,
    String? content,
    String? question,
    String? answer,
  }) {
    return FaqModel(question: question ?? this.question, answer: answer ?? this.answer);
  }

  @override
  String toString() {
    return 'InfoModel(  question: $question, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FaqModel && other.question == question && other.answer == answer;
  }

  @override
  int get hashCode {
    return question.hashCode ^ answer.hashCode;
  }
}
