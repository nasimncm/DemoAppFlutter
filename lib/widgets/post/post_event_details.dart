import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';

class PostEventDetails extends StatelessWidget {
  final Post post;

  const PostEventDetails({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    if (post.eventTitle == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingLarge,
        AppDimensions.paddingMedium,
        AppDimensions.paddingLarge,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.eventTitle!,
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 14,
              fontWeight: Fonts.semiBold,
              color: AppColors.textPrimary,
            ),
          ),
          if (post.eventDate != null) ...[
            const SizedBox(height: AppDimensions.spacingSmall),
            Text(
              post.eventDate!,
              style: TextStyle(
                fontFamily: Fonts.fontFamily,
                fontSize: 12,
                fontWeight: Fonts.regular,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

