/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 11:55:47
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/social/cubit/social_cubit.dart';
import 'package:pinlink/features/social/cubit/social_state.dart';
import 'package:pinlink/features/social/entity/post_entity.dart';
import 'package:pinlink/gen/assets.gen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

@RoutePage()
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final TextEditingController _courseController = TextEditingController();
  FocusNode? _courseFocusNode;

  @override
  void initState() {
    super.initState();
    _courseFocusNode?.addListener(() {
      if (!_courseFocusNode!.hasFocus) {
        _hideOverlay();
      }
    });
  }

  void _showOverlay(
    BuildContext context,
    SocialCubit cubit,
    List<UserCourseModel> results,
  ) {
    _hideOverlay();

    if (results.isEmpty && _courseController.text.isEmpty) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width:
              MediaQuery.of(context).size.width -
              (Constants.bodyPadding.horizontal),
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 55),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              color: context.colors.bACKGROUND_darkCard,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.pRIMARY_brandClr.withValues(
                        alpha: .5,
                      ),
                      blurRadius: 8,
                      spreadRadius: 5,

                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: context.colors.pRIMARY_brandClr.withValues(
                      alpha: 0.2,
                    ),
                  ),
                ),
                child: results.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No course found',
                          style: TextStyle(
                            color: context.colors.tEXT_white.withValues(
                              alpha: 0.6,
                            ),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: results.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: context.colors.tEXT_sub.withValues(alpha: 0.1),
                        ),
                        itemBuilder: (context, index) {
                          final course = results[index];
                          return ListTile(
                            title: Text(
                              course.courseId?.name ?? '',
                              style: TextStyle(
                                color: context.colors.tEXT_white,
                              ),
                            ),
                            onTap: () {
                              cubit.addCourse(course);
                              _courseController.clear();
                              _hideOverlay();
                            },
                          );
                        },
                      ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

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
              create: () => SocialCubit(),
              builder: (context, cubit, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      20.height,
                      const BuildLabel('Course Name'),
                      Wrap(
                        spacing: 5,
                        alignment: .start,
                        children: state.courses
                            .map((e) => _chip(e, cubit))
                            .toList(),
                      ).start,
                      CompositedTransformTarget(
                        link: _layerLink,
                        child: CommonTextField(
                          controller: _courseController,
                          validation: (value) {
                            if (state.courses.isEmpty) {
                              return 'Please select a course';
                            }
                            return null;
                          },
                          prefixBuilder: (controller, focusNode) {
                            _courseFocusNode = focusNode;
                            return null;
                          },
                          validationType: ValidationType.validateRequired,
                          onSaved: (value, controller) =>
                              entity.courseName = value,
                          hintText: 'Select golf course...',
                          onChanged: (value) {
                            cubit.searchCourses(value);
                            // We need to wait for the next frame to get updated results if we use state directly here
                            // Or better, trigger overlay update based on state change
                          },
                          // suffixBuilder: (controller, focusNode) {
                          //   return GestureDetector(
                          //     onTap: () {
                          //       focusNode.unfocus();
                          //       final value = controller.text.trim();
                          //       if (value.isEmpty) return;
                          //       controller.clear();
                          //       cubit.addCourse(value);
                          //       _hideOverlay();
                          //     },
                          //     child: const Icon(Icons.send),
                          //   );
                          // },
                        ),
                      ),
                      // Listener to update overlay when state changes
                      BlocListener<SocialCubit, CreateSocialPostState>(
                        bloc: cubit,
                        listenWhen: (previous, current) =>
                            previous.searchResults != current.searchResults,
                        listener: (context, state) {
                          if (state.searchResults.isNotEmpty ||
                              _courseController.text.isNotEmpty) {
                            _showOverlay(context, cubit, state.searchResults);
                          } else {
                            _hideOverlay();
                          }
                        },
                        child: const SizedBox.shrink(),
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
                        maxLength: 500,
                        minLength: 300,
                        height: 150,
                        multilineLimitHintBuilder: MultilineHintLimitBuilder(
                          minimumHint: (current, limit) =>
                              Text('\tMinimum $limit'),
                          maximumHint: (current, limit) =>
                              Text('Maximum $current / $limit'),
                        ),
                        hintText: 'Enter the description',
                        validationType: ValidationType.validateRequired,
                        onChanged: (value) => entity.description = value,
                      ),
                      12.height,
                      Row(
                        children: [
                          Expanded(
                            child: CommonText(
                              text: 'Scorecard Information',
                              fontSize: 16,
                              textColor: context.colors.tEXT_subDark,
                            ),
                          ),
                          SegmentedButton<bool>(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                              minimumSize: WidgetStateProperty.all(
                                const Size.fromHeight(50),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: context
                                        .colors
                                        .successVerifiedPositivestats_freshGrass,
                                  ),
                                ),
                              ),
                            ),

                            showSelectedIcon: false,
                            segments: <ButtonSegment<bool>>[
                              ButtonSegment<bool>(
                                value: true,
                                label: CommonImage(
                                  src: Assets.images.globe.path,
                                  size: 20,
                                ),
                              ),
                              ButtonSegment<bool>(
                                value: false,
                                label: CommonImage(
                                  src: Assets.images.privacyIcon,
                                  size: 20,
                                  imageColor: state.isPublic
                                      ? Colors.white
                                      : context.colors.pRIMARY_brandClr,
                                ),
                              ),
                            ],
                            selected: <bool>{state.isPublic},
                            onSelectionChanged: (value) {
                              cubit.changePrivacy();
                              entity.isScorePublic = state.isPublic;
                            },
                          ),
                        ],
                      ),
                      12.height,
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
                                  validationType:
                                      ValidationType.validateRequired,
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
                                  validationType:
                                      ValidationType.validateRequired,
                                  hintText: 'e.g., 70',
                                  onChanged: (value) =>
                                      entity.totalScore = value,
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
                        children: state.links
                            .map((e) => _chipForLink(e, cubit))
                            .toList(),
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
                            child: const Icon(Icons.add),
                          );
                        },
                      ),
                      8.height,
                      const BuildLabel('Media'),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemBuilder: (context, index) {
                          return _imageItems(context, index, state, cubit);
                        },
                        itemCount: state.files.length + 1,
                      ),
                      20.height,
                      CommonButton(
                        titleText: 'Post',
                        isLoading: state.isPosting,
                        buttonWidth: .infinity,
                        onTap: () {
                          if (formKey.validateAndSave()) {
                            cubit.createPost(entity);
                          }
                        },
                      ),
                      50.height,
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _imageItems(
    BuildContext context,
    int index,
    CreateSocialPostState state,
    SocialCubit cubit,
  ) {
    if (index == state.files.length) {
      return GestureDetector(
        onTap: () {
          cubit.pickImage();
        },
        child: DashedBorderContainer(
          borderRadius: 12,
          color: context.colors.tEXT_subDark,
          child: Icon(Icons.image, color: context.colors.tEXT_sub),
        ),
      );
    }
    final isVideo = cubit.isVideo(state.files[index]);
    return Stack(
      children: [
        Positioned.fill(
          child: isVideo
              ? FutureBuilder(
                  future: VideoThumbnail.thumbnailData(
                    video: state.files[index].path,
                    imageFormat: ImageFormat.JPEG,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.memory(snapshot.data!, fit: BoxFit.cover);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )
              : CommonImage(borderRadius: 12, src: state.files[index].path),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
            onTap: () {
              cubit.removeImage(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .2),
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),

        if (isVideo)
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .1),
              ),
              child: const Icon(Icons.play_arrow, size: 50, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _chip(UserCourseModel text, SocialCubit cubit) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Chip(
        label: Text(text.courseId?.name ?? '', overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.amber.withValues(
          alpha: 0.2,
        ), // change background color here
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

  Widget _chipForLink(String text, SocialCubit cubit) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Chip(
        label: Text(text, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.blue.withValues(
          alpha: 0.2,
        ), // change background color here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(width: 0),
        ),
        labelStyle: TextStyle(color: Colors.blue.shade800),
        deleteIcon: Icon(Icons.close, size: 18, color: Colors.grey.shade400),
        onDeleted: () {
          cubit.removeLink(text);
        },
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
