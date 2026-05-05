import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/constant/constants.dart';

@RoutePage()
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: 'Talk to Support'),
      body: Padding(
        padding: Constants.bodyPadding,
        child: FormBuilder(
          entity: null,
          builder: (context, formKey, entity) {
            return Column(
              children: [
                20.height,
                const BuildLabel('Title'),
                const CommonTextField(
                  validationType: ValidationType.validateRequired,
                  hintText: 'Enter the title of report',
                ),
                10.height,
                const BuildLabel('Description'),
                const CommonMultilineTextField(
                  height: 200,
                  validationType: ValidationType.validateRequired,
                  hintText: 'Enter the description of reason',
                ),
                20.height,
                CommonButton(buttonWidth: .infinity, titleText: 'Submit', onTap: () {}),
              ],
            );
          },
        ),
      ),
    );
  }
}
