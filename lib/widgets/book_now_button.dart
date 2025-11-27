import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/fonts.dart';

class BookNowButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BookNowButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: AppDimensions.paddingSmall),
            child: ElevatedButton(
              onPressed: onPressed ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.followColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: AppDimensions.paddingLarge,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Book Now',
                    style: TextStyle(
                      fontFamily: Fonts.fontFamily,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: Fonts.medium,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: AppDimensions.sidebarWidth),
      ],
    );
  }
}

