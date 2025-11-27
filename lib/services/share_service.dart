import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/post.dart';

class ShareService {
  ShareService._();

  static Future<void> sharePost(Post post, BuildContext context) async {
    try {
      final title = post.eventTitle ?? post.venueName;
      String description = '';

      if (post.caption != null) {
        description = post.caption!;
      } else if (post.eventDate != null) {
        description = post.eventDate!;
      }

      if (post.location.isNotEmpty && post.location != 'Check in') {
        description += description.isNotEmpty
            ? '\n📍 ${post.location}'
            : '📍 ${post.location}';
      }

      String shareText = title;
      if (description.isNotEmpty) {
        shareText += '\n\n$description';
      }
      shareText += '\n\nwww.google.com';

      await Share.share(shareText, subject: title);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to share. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

