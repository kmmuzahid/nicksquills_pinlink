import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';

class PostTextWidget extends StatefulWidget {
  const PostTextWidget({super.key, required this.text});

  final String text;

  @override
  State<PostTextWidget> createState() => _PostTextWidgetState();
}

class _PostTextWidgetState extends State<PostTextWidget> {
  bool isMoreShown = false; // This should be in your State class

  @override
  Widget build(BuildContext context) {
    final fullText = widget.text;

    // Define how many characters to show before "Show More"
    const trimLength = 100;

    // Logic to determine what text to actually display
    final isLongText = fullText.length > trimLength;
    final displayContent = (isLongText && !isMoreShown)
        ? "${fullText.substring(0, trimLength)}..."
        : fullText;

    return SingleChildScrollView(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: displayContent,
              style: const TextStyle(color: Color(0xffB2CBC1), fontSize: 12),
            ),
            if (isLongText)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isMoreShown = !isMoreShown;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      isMoreShown ? " Show Less" : " More...",
                      textAlign: .end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        // Ensure maxLines is null when expanded so it shows everything
        maxLines: isMoreShown ? null : 2,
        overflow: isMoreShown ? TextOverflow.visible : TextOverflow.fade,
      ),
    );
  }
}
