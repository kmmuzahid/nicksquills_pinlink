import 'dart:math';

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';

class GolfCoursePlayedItem extends StatefulWidget {
  const GolfCoursePlayedItem({
    super.key,
    required this.course,
    required this.index,
    required this.selectedFilter,
    required this.controllers,
  });
  final CourseModel course;
  final int index;
  final MapFilters? selectedFilter;
  final Map<String, ScrollController> controllers;

  @override
  State<GolfCoursePlayedItem> createState() => _GolfCoursePlayedItemState();
}

class _GolfCoursePlayedItemState extends State<GolfCoursePlayedItem> {
  late ScrollController controller;
  late String id;
  bool _isSyncingScroll = false;

  @override
  void initState() {
    id = DateTime.now().microsecondsSinceEpoch.toString();

    double initialOffset = 0;
    if (widget.controllers.isNotEmpty) {
      final existing = widget.controllers.values.firstWhere(
        (c) => c.hasClients,
        orElse: () => ScrollController(),
      );
      if (existing.hasClients) initialOffset = existing.offset;
    }

    controller = ScrollController(initialScrollOffset: initialOffset);

    controller.addListener(() {
      if (_isSyncingScroll) return;

      if (!controller.position.isScrollingNotifier.value &&
          controller.position.activity is! DragScrollActivity) {
        return;
      }

      _isSyncingScroll = true;
      final sourceOffset = controller.offset;

      for (final entry in widget.controllers.entries) {
        if (entry.key == id) continue;
        final target = entry.value;

        if (target.hasClients) {
          if ((target.offset - sourceOffset).abs() > 0.1) {
            target.jumpTo(
              sourceOffset.clamp(0.0, target.position.maxScrollExtent),
            );
          }
        }
      }
      _isSyncingScroll = false;
    });

    widget.controllers[id] = controller;
    super.initState();
  }

  @override
  void dispose() {
    widget.controllers.remove(id);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCourseCard(context, widget.course, widget.index);
  }

  Widget _buildCourseCard(BuildContext context, CourseModel course, int index) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final rattingWidth = ((constrains.maxWidth * .68) - 32) / 3.5;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          width: rattingWidth,
          decoration: BoxDecoration(
            color: context.colors.bACKGROUND_darkCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.colors.bACKGROUND_darkCardBoarder,
              width: 1.4,
            ),
          ),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              TextToAvatar(
                size: 35,
                text: (index + 1).toString(),
                color: getGolfPrimaryColor(widget.selectedFilter),
              ),
              SizedBox(
                width: (constrains.maxWidth * .40) - 35,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: course.name,
                      fontSize: 14,
                      left: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      preventScaling: true,
                      textColor: context.colors.tEXT_white,
                      fontWeight: FontWeight.bold,
                    ).start,
                    CommonText(
                      text: course.address,
                      left: 10,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      preventScaling: true,
                      textColor: context.colors.pRIMARY_priSoft,
                      fontWeight: FontWeight.w400,
                    ).start,
                    CommonText(
                      text: '🤾‍♂️ 2024-01-15',
                      left: 10,
                      fontSize: 11,
                      textColor: context.colors.tEXT_sub,
                      fontWeight: FontWeight.w400,
                    ).start,
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    controller: controller,
                    itemCount: RatingCategories.values.length,
                    shrinkWrap: true,
                    scrollDirection: .horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            5.height,
                            Row(
                              children: [
                                ...List.generate(
                                  3,
                                  (_) => rattingIcon(
                                    index == 0
                                        ? Colors.amber
                                        : context.colors.tEXT_sub,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  2,
                                  (_) => rattingIcon(
                                    index == 0
                                        ? Colors.amber
                                        : context.colors.tEXT_sub,
                                  ),
                                ),
                              ],
                            ),

                            5.height,
                            if (index == 0)
                              Text(
                                '5.0',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.colors.tEXT_white,
                                ),
                              ),
                            if (index != 0) ...[
                              Icon(
                                Icons.lock,
                                color: context.colors.tEXT_sub,
                                size: 14,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //ratting icon
  Widget rattingIcon(Color color) {
    return Icon(Icons.star, color: color, size: 14);
  }
}
