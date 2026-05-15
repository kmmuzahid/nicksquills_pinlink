import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';

class GolfCoursePlayedItem extends StatefulWidget {
  const GolfCoursePlayedItem({
    super.key,
    required this.course,
    required this.index,
    required this.selectedFilter,
    required this.controllers,
    required this.fixedWidth,
    required this.rattingWidth,
  });
  final UserCourseModel course;
  final int index;
  final MapFilters? selectedFilter;
  final Map<String, ScrollController> controllers;
  final double fixedWidth;
  final double rattingWidth;

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

  Widget _buildCourseCard(
    BuildContext context,
    UserCourseModel course,
    int index,
  ) {
    final child = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
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
          SizedBox(
            width: widget.fixedWidth,
            child: Row(
              children: [
                TextToAvatar(
                  size: 35,
                  text: (index + 1).toString(),
                  color: getGolfPrimaryColor(widget.selectedFilter),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: course.name ?? '',
                        fontSize: 12,
                        left: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        preventScaling: true,
                        textColor: context.colors.tEXT_white,
                        fontWeight: FontWeight.bold,
                      ).start,
                      CommonText(
                        text: course.locationName ?? '',
                        left: 10,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        preventScaling: true,
                        textColor: context.colors.pRIMARY_priSoft,
                        fontWeight: FontWeight.w400,
                      ).start,
                      CommonText(
                        text: '2024-01-15',
                        left: 10,
                        fontSize: 11,
                        textColor: context.colors.tEXT_sub,
                        fontWeight: FontWeight.w400,
                      ).start,
                    ],
                  ),
                ),
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
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: widget.rattingWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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

    if (widget.selectedFilter == MapFilters.Played) {
      return ReorderableDragStartListener(index: index, child: child);
    }
    return child;
  }

  //ratting icon
  Widget rattingIcon(Color color) {
    return Icon(Icons.star, color: color, size: 12);
  }
}
