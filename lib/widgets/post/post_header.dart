import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';
import '../../utils/image_helper.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingLarge,
        AppDimensions.paddingMedium,
        AppDimensions.paddingLarge,
        AppDimensions.paddingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageHelper.buildProfileImage(post.profileImage),
                const SizedBox(width: AppDimensions.spacingMedium),
                Expanded(
                  child: _buildUserInfo(),
                ),
              ],
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              post.venueName,
              style: TextStyle(
                fontFamily: Fonts.fontFamily,
                fontSize: 16,
                fontWeight: Fonts.semiBold,
                color: AppColors.textPrimary,
              ),
            ),
            if (post.isVerified) ...[
              const SizedBox(width: 2),
              SvgPicture.asset(
                ImageHelper.getImagePath('verified'),
                width: 16,
                height: 16,
              ),
            ],
            const SizedBox(width: 6),
            Text(
              '◆ ${post.time}',
              style: const TextStyle(
                fontFamily: Fonts.fontFamily,
                fontSize: 12,
                fontWeight: Fonts.regular,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          post.location,
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            fontSize: 12,
            fontWeight: Fonts.regular,
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: post.isVenue ? AppColors.reserveColor : AppColors.followColor,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
          child: Text(
            post.isVenue ? 'Reserve' : 'Follow',
            style: const TextStyle(
              fontFamily: Fonts.fontFamily,
              color: Colors.white,
              fontSize: 12,
              fontWeight: Fonts.regular,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Icon(
          Icons.more_horiz,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}

