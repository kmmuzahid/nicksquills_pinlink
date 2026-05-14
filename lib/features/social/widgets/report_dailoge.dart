import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/config/color/app_color.dart';

class ReportDialog extends StatelessWidget {
  const ReportDialog({super.key, required this.postId, required this.onReport});

  final String postId;
  final Function(String reason) onReport;

  static const List<String> _reportReasons = [
    'Spam',
    'Harassment',
    'Inappropriate Content',
    'False Information',
    'Hate Speech',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    var selectedReason = _reportReasons.first;
    final otherReasonController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.colors.bACKGROUND_darkCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colors.pRIMARY_brandClr.withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: 'Report Post',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: context.colors.tEXT_white,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: context.colors.tEXT_white),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                8.height,
                CommonText(
                  text: 'Why are you reporting this post?',
                  fontSize: 14,
                  textColor: context.colors.tEXT_subDark,
                ),
                15.height,
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final isSelected =
                          selectedReason == _reportReasons[index];
                      return GestureDetector(
                        onTap: () => setState(
                          () => selectedReason = _reportReasons[index],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonText(
                                  text: _reportReasons[index],
                                  fontSize: 14,
                                  textColor: context.colors.tEXT_white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: context.colors.tEXT_white,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const CustomDivider(),
                    itemCount: _reportReasons.length,
                  ),
                ),
                if (selectedReason == 'Other') ...[
                  10.height,
                  CommonTextField(
                    controller: otherReasonController,
                    hintText: 'Please describe the issue...',
                    borderRadius: 12,
                    validationType: .validateRequired,
                    borderColor: context.colors.tEXT_sub.withValues(alpha: 0.2),
                  ),
                ],
                20.height,
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        titleText: 'Cancel',
                        buttonColor: Colors.transparent,
                        titleColor: context.colors.tEXT_subDark,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    15.width,
                    Expanded(
                      child: CommonButton(
                        titleText: 'Submit Report',

                        onTap: () {
                          final finalReason = selectedReason == 'Other'
                              ? otherReasonController.text
                              : selectedReason;

                          if (selectedReason == 'Other' &&
                              finalReason.isEmpty) {
                            showSnackBar(
                              'Please provide a reason',
                              type: SnackBarType.error,
                            );
                            return;
                          }

                          onReport(finalReason);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
