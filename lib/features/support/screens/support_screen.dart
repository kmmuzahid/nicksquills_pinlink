import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/support/cubit/support_cubit.dart';

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
          // ignore: prefer_const_literals_to_create_immutables
          entity: {},
          builder: (context, formKey, entity) {
            return CubitScope(
              create: () => SupportCubit(),
              builder: (context, cubit, state) {
                return Column(
                  children: [
                    20.height,
                    const BuildLabel('Title'),
                    CommonTextField(
                      validationType: ValidationType.validateRequired,
                      hintText: 'Enter the title of report',
                      onSaved: (value, _) {
                        entity['title'] = value;
                      },
                    ),
                    10.height,
                    const BuildLabel('Description'),
                    CommonMultilineTextField(
                      height: 200,
                      validationType: ValidationType.validateRequired,
                      hintText: 'Enter the description of reason',
                      onSaved: (value, _) {
                        entity['description'] = value;
                      },
                    ),
                    20.height,
                    CommonButton(
                      buttonWidth: .infinity,
                      titleText: 'Submit',
                      isLoading: state.isLoading,
                      onTap: () {
                        if (formKey.validateAndSave()) {
                          cubit.submitToSupport(
                            title: entity['title'] ?? '',
                            description: entity['description'] ?? '',
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
