import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/constant/enums.dart';

class CategoryScrolledList extends StatefulWidget {
  const CategoryScrolledList({
    super.key,
    required this.rattingWidth,
    required this.controllers,
  });
  final double rattingWidth;
  final Map<String, ScrollController> controllers;

  @override
  State<CategoryScrolledList> createState() => _CategoryScrolledListState();
}

class _CategoryScrolledListState extends State<CategoryScrolledList> {
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
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: .horizontal,
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          ...List.generate(
            RatingCategories.values.length,
            (index) => SizedBox(
              width: widget.rattingWidth,
              child: CommonText(
                alignment: .center,
                textAlign: .center,
                maxLines: 3,
                fontSize: 11,
                fontWeight: .bold,
                text: RatingCategories.values[index].displayName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
