/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 08:35:35
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/social_item_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/features/social/cubit/social_cubit.dart';
import 'package:pinlink/features/social/widgets/report_dailoge.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key, required this.socialCubit});
  final SocialCubit socialCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CubitScopeValue(
        cubit: socialCubit,
        builder: (context, cubit, state) {
          return SmartStaggeredLoader(
            padding: .only(bottom: 40.h),
            appbar: _topWidget(context, cubit),
            onColapsAppbar: Container(
              padding: const .only(bottom: 4),
              color: context.colors.background,
              child: _header(cubit),
            ),
            isLoading: state.isPostLoaing,
            gridConfig: GridConfig(aspectRatio: 0.65),
            itemCount: state.posts.length,
            onRefresh: () {
              cubit.getAllPost(isRefresh: true, page: 1);
            },
            onLoadMore: (page) {
              cubit.getAllPost(page: page);
            },
            limit: 10,
            itemBuilder: (context, index) => SocialItemWidget(
              postModel: state.posts[index],
              onChanged: (postModel) {
                cubit.updatePost(postModel);
              },
              onReportPost: () {
                showDialog(
                  context: context,
                  builder: (context) => ReportDialog(
                    postId: state.posts[index].id ?? '',
                    onReport: (reason) {
                      cubit.createPostReport(
                        state.posts[index].id ?? '',
                        reason,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column _topWidget(BuildContext context, SocialCubit cubit) {
    return Column(
      children: [
        8.height,
        CommonText(
          text: 'See what your friends are playing and sharing',
          fontSize: 16,
          textColor: context.colors.tEXT_subDark,
          maxLines: 2,
        ).center,
        8.height,
        _header(cubit),
        // 18.height,
        // consentCard(context),
        // 8.height,
        // .end,
        10.height,
      ],
    );
  }

  Row _header(SocialCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            key: ValueKey('social_search_${cubit.state.isPublicPostEnabled}'),
            hintText: 'Search content',
            validationType: .notRequired,
            borderRadius: 10,
            onChanged: (value) {
              cubit.searchPost(value);
            },
          ),
        ),
        8.width,
        CommonButton(
          titleText: 'Create Post',
          prefix: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 1.4.r),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          onTap: () {
            appRouter.push(const CreatePostRoute());
          },
        ),
      ],
    );
  }

  Widget consentCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder),
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CommonText(
            text: 'Golf-Only Content',
            textColor: context.colors.tEXT_white,
            fontSize: 14,
            fontWeight: .bold,
          ).start,
          10.height,
          CommonText(
            text:
                'Posts are moderated to keep the feed focused on golf experiences, courses, and scores.',
            fontSize: 13,
            textColor: context.colors.tEXT_subDark,
            maxLines: 5,
            textAlign: .left,
          ).start,
          15.height,
          Row(
            children: [
              CommonText(
                text: 'Profanity Filter',
                fontSize: 14,
                textColor: context.colors.tEXT_white,
              ),
              const Spacer(),
              Switch(
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF2F6F57),
                inactiveThumbColor: Colors.grey.shade400,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                inactiveTrackColor: Colors.grey.shade200,
                trackOutlineWidth: const WidgetStatePropertyAll(0),
                trackOutlineColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
