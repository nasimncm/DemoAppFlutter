import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';
import '../../utils/image_helper.dart';

class PostCaption extends StatelessWidget {
  final Post post;

  const PostCaption({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    if (post.caption == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                post.userName.replaceAll(' ', '.'),
                style: TextStyle(
                  fontFamily: Fonts.fontFamily,
                  fontSize: 14,
                  fontWeight: Fonts.semiBold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (post.isVerified) ...[
                const SizedBox(width: AppDimensions.spacingSmall),
                SvgPicture.asset(
                  ImageHelper.getImagePath('verified'),
                  width: 14,
                  height: 14,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          Text(
            post.caption!,
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 14,
              fontWeight: Fonts.regular,
              color: AppColors.textPrimary,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}

