import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../models/post.dart';
import '../../services/share_service.dart';
import 'post_caption.dart';
import 'post_content.dart';
import 'post_event_details.dart';
import 'post_header.dart';
import 'post_social_sidebar.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final double slideWidth;

  const PostItem({
    super.key,
    required this.post,
    required this.slideWidth,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool _isLiked = false;
  bool _isBookmarked = false;
  bool _isStarred = false;

  @override
  Widget build(BuildContext context) {
    final imageHeight = widget.post.hasPromo
        ? AppDimensions.imageHeight + 40
        : AppDimensions.imageHeight;

    return Container(
      color: AppColors.postBackgroundColor,
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingLarge),
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: widget.post),
          PostContent(
            post: widget.post,
            slideWidth: widget.slideWidth,
            sidebar: PostSocialSidebar(
              post: widget.post,
              containerHeight: imageHeight,
              isLiked: _isLiked,
              isBookmarked: _isBookmarked,
              isStarred: _isStarred,
              onLike: _handleLike,
              onBookmark: _handleBookmark,
              onStar: _handleStar,
              onComment: () {},
              onShare: _handleShare,
            ),
          ),
          if (widget.post.caption != null) PostCaption(post: widget.post),
          if (widget.post.eventTitle != null)
            PostEventDetails(post: widget.post),
        ],
      ),
    );
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _handleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _handleStar() {
    setState(() {
      _isStarred = !_isStarred;
    });
  }

  void _handleShare() {
    ShareService.sharePost(widget.post, context);
  }
}

