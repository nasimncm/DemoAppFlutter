import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../models/post.dart';
import '../../utils/image_helper.dart';

class PostImageCarousel extends StatefulWidget {
  final Post post;
  final double slideWidth;

  const PostImageCarousel({
    super.key,
    required this.post,
    required this.slideWidth,
  });

  @override
  State<PostImageCarousel> createState() => _PostImageCarouselState();
}

class _PostImageCarouselState extends State<PostImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.post.multipleImages ?? [];
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.imageHeight,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: widget.slideWidth,
                child: ImageHelper.buildDummyImage(images[index]),
              );
            },
          ),
          if (images.length > 1) _buildPageIndicator(images.length),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int totalPages) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              totalPages,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 28 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppColors.followColor
                      : Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

