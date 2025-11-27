import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';
import '../../utils/image_helper.dart';
import '../animated_action_button.dart';

class PostSocialSidebar extends StatelessWidget {
  final Post post;
  final double containerHeight;
  final bool isLiked;
  final bool isBookmarked;
  final bool isStarred;
  final VoidCallback onLike;
  final VoidCallback onBookmark;
  final VoidCallback onStar;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostSocialSidebar({
    super.key,
    required this.post,
    required this.containerHeight,
    required this.isLiked,
    required this.isBookmarked,
    required this.isStarred,
    required this.onLike,
    required this.onBookmark,
    required this.onStar,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.sidebarWidth,
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: AnimatedActionButton(
                  iconName: 'star',
                  isActive: isStarred,
                  activeColor: AppColors.starredColor,
                  onPressed: onStar,
                ),
                onPressed: onStar,
              ),
              const SizedBox(height: 0),
              IconButton(
                icon: AnimatedActionButton(
                  iconName: 'bookmark',
                  isActive: isBookmarked,
                  activeColor: AppColors.bookmarkedColor,
                  onPressed: onBookmark,
                ),
                onPressed: onBookmark,
              ),
            ],
          ),
          Column(
            children: [
              _buildSocialIcon(
                icon: AnimatedActionButton(
                  iconName: 'heart',
                  isActive: isLiked,
                  activeColor: AppColors.likedColor,
                  onPressed: onLike,
                ),
                label: post.likes,
                onPressed: onLike,
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              _buildSocialIcon(
                icon: SvgPicture.asset(
                  ImageHelper.getImagePath('comment'),
                  width: AppDimensions.iconSize,
                  height: AppDimensions.iconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                label: post.comments,
                onPressed: onComment,
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              _buildSocialIcon(
                icon: SvgPicture.asset(
                  ImageHelper.getImagePath('paper-plane'),
                  width: AppDimensions.iconSize,
                  height: AppDimensions.iconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                label: post.shares,
                onPressed: onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(icon: icon, onPressed: onPressed),
        Text(
          label,
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            fontSize: 10,
            fontWeight: Fonts.medium,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

