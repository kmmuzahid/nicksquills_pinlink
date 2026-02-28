import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/entity/add_course_entity.dart';

class NewCourseDailogueWidget extends StatelessWidget {
  const NewCourseDailogueWidget({super.key, required this.cubit, required this.onPostNewScore});
  final AddCourseCubit cubit;
  final Function onPostNewScore;

  @override
  Widget build(BuildContext context) {
    final cardBg = context.colors.bACKGROUND_darkCard;
    final accentOrange = context.colors.ratingPremiumTags_goldAccent;

    return _content(cardBg, context, accentOrange);
  }

  Widget _content(Color cardBg, BuildContext context, Color accentOrange) {
    return CubitScopeValue(
      cubit: cubit,
      builder: (context, cubit, state) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16)),
        child: FormBuilder(
          entity: AddCourseEntity(),
          builder: (context, formKey, entity) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    text: 'Add Match Details',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  IconButton(
                    icon: Icon(Icons.close, color: context.colors.tEXT_subDark, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              14.height,

              // Played Date
              const BuildLabel('Played Date'),
              CommonDateInputTextField(
                borderRadius: 40,
                hints: 'Select match date',
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),

              // Notes
              const BuildLabel('Notes'),
              const SizedBox(
                height: 80,
                child: CommonMultilineTextField(
                  borderRadius: 20,
                  validationType: .validateRequired,
                  hintText: 'Add any notes ab out this match...',
                ),
              ),
              const SizedBox(height: 20),

              // Tag Friends
              const BuildLabel('Tag Friends'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.tags.map((e) => _buildTag(e, accentOrange)).toList(),
              ),
              const SizedBox(height: 12),
              CommonTextField(
                hintText: 'Search and tag friends you played with..',
                validationType: .notRequired,
                suffixIcon: Icon(Icons.send_outlined, color: context.colors.tEXT_subDark, size: 20),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),

              // Your Score
              const BuildLabel('Your Score'),
              _buildTextField(hint: 'Enter your total score (e.g., 72)', context: context),
              const SizedBox(height: 30),

              // Submit Button
              CommonButton(
                buttonWidth: 130,
                titleText: 'Submit',
                onTap: () {
                  Navigator.pop(context);
                  onPostNewScore();
                },
              ).center,
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Input Fields
  Widget _buildTextField({
    required String hint,
    IconData? suffixIcon,
    required BuildContext context,
  }) {
    return CommonTextField(
      hintText: hint,
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: context.colors.tEXT_subDark, size: 20)
          : null,
      validationType: .validateRequired,
    );
  }

  // Helper widget for Tags
  Widget _buildTag(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Icon(Icons.close, size: 14, color: color.withOpacity(0.6)),
        ],
      ),
    );
  }
}
