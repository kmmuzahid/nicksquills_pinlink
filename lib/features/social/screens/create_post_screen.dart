/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 11:55:47
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/social/cubit/social_cubit.dart';
import 'package:pinlink/features/social/entity/post_entity.dart';

@RoutePage()
class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: 'Create Post'),
      body: Padding(
        padding: Constants.bodyPadding,
        child: FormBuilder(
          entity: PostEntity(),
          builder: (context, formKey, entity) {
            return CubitScope(
              create: () => CreateSocialPostCubit(),
              builder: (context, cubit, state) {
                return Column(
                  children: [
                    20.height,
                    const BuildLabel('Course Name'),
                    Wrap(
                      spacing: 5,
                      alignment: .start,
                      children: state.courses.map((e) => _chip(e, cubit)).toList(),
                    ).start,
                    CommonTextField(
                      validationType: ValidationType.notRequired,
                      hintText: 'Share & select golf course...',
                      suffixBuilder: (controller, focusNode) {
                        return GestureDetector(
                          onTap: () {
                            focusNode.unfocus();
                            final value = controller.text.trim();
                            if (value.isEmpty) return;
                            controller.clear();
                            cubit.addCourse(value);
                          },
                          child: const Icon(Icons.send),
                        );
                      },
                    ),
                    8.height,
                    const BuildLabel('Headline'),

                    CommonTextField(
                      validationType: ValidationType.validateRequired,
                      hintText: 'Enter the caption',
                      onChanged: (value) => entity.headline = value,
                    ),
                    8.height,
                    const BuildLabel('Description'),
                    CommonMultilineTextField(
                      height: 150,
                      borderRadius: 20,
                      hintText: 'Enter the description',
                      validationType: ValidationType.validateRequired,
                      onChanged: (value) => entity.description = value,
                    ),
                    8.height,
                    const BuildLabel('Date'),
                    CommonDateInputTextField(
                      initialValue: entity.holes,
                      borderRadius: 30,
                      onChanged: (value) => entity.date = value,
                    ),
                    8.height,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const BuildLabel('Holes'),

                              CommonTextField(
                                validationType: ValidationType.validateRequired,
                                hintText: 'e.g., 9/18',
                                onChanged: (value) => entity.holes = value,
                              ),
                            ],
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            children: [
                              const BuildLabel('Total Score'),

                              CommonTextField(
                                validationType: ValidationType.validateRequired,
                                hintText: 'e.g., 70',
                                onChanged: (value) => entity.totalScore = value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    const BuildLabel('Link'),
                    Wrap(
                      spacing: 5,
                      alignment: .start,
                      children: state.links.map((e) => _chip(e, cubit)).toList(),
                    ).start,
                    CommonTextField(
                      validationType: ValidationType.notRequired,
                      hintText: 'www.google.com',
                      suffixBuilder: (controller, focusNode) {
                        return GestureDetector(
                          onTap: () {
                            focusNode.unfocus();
                            final value = controller.text.trim();
                            if (value.isEmpty) return;
                            controller.clear();
                            cubit.addLink(value);
                          },
                          child: const Icon(Icons.send),
                        );
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

  Widget _chip(String text, CreateSocialPostCubit cubit) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Chip(
        label: Text(text, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.amber.withValues(alpha: 0.2), // change background color here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(width: 0),
        ),
        labelStyle: TextStyle(color: Colors.amber.shade800),
        deleteIcon: Icon(Icons.close, size: 18, color: Colors.grey.shade400),
        onDeleted: () {
          cubit.removeCourse(text);
        },
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
