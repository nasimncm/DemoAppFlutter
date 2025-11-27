import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';
import '../../utils/image_helper.dart';

class PostSingleImage extends StatelessWidget {
  final Post post;

  const PostSingleImage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.imageHeight,
      child: Stack(
        children: [
          ImageHelper.buildDummyImage(post.imageSource),
          if (post.hasFoodTag) _buildFoodTag(),
        ],
      ),
    );
  }

  Widget _buildFoodTag() {
    return Positioned(
      top: 50,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: const BoxDecoration(
          color: AppColors.foodTagColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.borderRadiusLarge),
            bottomLeft: Radius.circular(AppDimensions.borderRadiusLarge),
          ),
        ),
        child: const Text(
          'Food',
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            color: Colors.white,
            fontSize: 13,
            fontWeight: Fonts.semiBold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

