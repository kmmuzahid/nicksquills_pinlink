import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';

class CourseSearchOverlayManager {
  final FocusNode focusNode;
  final LayerLink layerLink;
  OverlayEntry? _overlayEntry;
  CourseSearchOverlayManager(this.focusNode, this.layerLink);

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void dispose() {
    hideOverlay();
  }

  void showOverlay({
    required BuildContext context,
    required List<CourseModel> results,
    required bool isSearching,
    required String searchText,
    required void Function(CourseModel) onCourseSelected,
  }) {
    hideOverlay();

    if (results.isEmpty && searchText.isEmpty) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width:
              MediaQuery.of(context).size.width -
              (Constants.bodyPadding.horizontal),
          child: CompositedTransformFollower(
            link: layerLink,
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
                          isSearching ? 'Searching...' : 'no result',
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
                              course.name ?? '',
                              style: TextStyle(
                                color: context.colors.tEXT_white,
                              ),
                            ),
                            onTap: () {
                              onCourseSelected(course);
                              focusNode.unfocus();
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
}
