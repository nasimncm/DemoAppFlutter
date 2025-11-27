import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/fonts.dart';
import '../../models/post.dart';
import 'post_image_carousel.dart';
import 'post_single_image.dart';
import '../book_now_button.dart';

class PostContent extends StatelessWidget {
  final Post post;
  final double slideWidth;
  final Widget sidebar;

  const PostContent({
    super.key,
    required this.post,
    required this.slideWidth,
    required this.sidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: AppDimensions.paddingSmall),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (post.hasPromo) _buildPromoBanner(),
                      post.multipleImages != null
                          ? PostImageCarousel(post: post, slideWidth: slideWidth)
                          : PostSingleImage(post: post),
                    ],
                  ),
                ),
              ),
              sidebar,
            ],
          ),
          if (post.isVenue)
            Transform.translate(
              offset: const Offset(0, -4),
              child: const BookNowButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: AppDimensions.paddingLarge,
      ),
      color: AppColors.promoColor,
      child: Text(
        post.promoText ?? '',
        style: const TextStyle(
          fontFamily: Fonts.fontFamily,
          fontSize: 12,
          fontWeight: Fonts.regular,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

