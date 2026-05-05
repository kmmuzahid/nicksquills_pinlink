/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 13:21:52
 * @Email: km.muzahid@gmail.com
 */
class ComparisonModel {
  final String question;
  final List<ComparisonOptionModel> options;

  ComparisonModel({required this.question, required this.options});
}

class ComparisonOptionModel {
  final String title;
  final bool isSelected;
  final String address;
  final String image;

  ComparisonOptionModel({
    required this.title,
    required this.isSelected,
    required this.address,
    required this.image,
  });
}
