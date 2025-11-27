import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/profile_image_with_fallback.dart';

class ImageHelper {
  ImageHelper._();

  static String getImagePath(String imageName) {
    return '${AppConstants.assetsPath}/$imageName.svg';
  }

  static String getImagePathPng(String imageName) {
    return '${AppConstants.assetsPath}/$imageName.png';
  }

  static String getImagePathJpg(String imageName) {
    return '${AppConstants.assetsPath}/$imageName.jpg';
  }

  static Widget buildDummyImage(String? imageName) {
    if (imageName == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.image, size: 100, color: Colors.grey),
        ),
      );
    }

    final imagePathPng = getImagePathPng(imageName);
    final imagePathJpg = getImagePathJpg(imageName);

    return Image.asset(
      imagePathPng,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          imagePathJpg,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            );
          },
        );
      },
    );
  }

  static Widget buildProfileImage(String? profileImage) {
    final imageName = profileImage ?? AppConstants.defaultProfileImage;
    return ClipOval(
      child: ProfileImageWithFallback(
        pngPath: getImagePathPng(imageName),
        svgPath: getImagePath(imageName),
        width: 48.0,
        height: 48.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

