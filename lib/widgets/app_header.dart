import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_dimensions.dart';
import '../constants/fonts.dart';
import '../utils/image_helper.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      color: AppColors.backgroundColor,
      child: Row(
        children: [
          _buildAppIcon(),
          const SizedBox(width: AppDimensions.spacingMedium),
          Expanded(
            child: _buildLocationSelector(),
          ),
          const SizedBox(width: AppDimensions.spacingMedium),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildAppIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        child: SvgPicture.asset(
          ImageHelper.getImagePath('app-icon'),
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSmall,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.locationBackgroundColor,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                ImageHelper.getImagePath('location'),
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                AppConstants.defaultLocation,
                style: TextStyle(
                  fontFamily: Fonts.fontFamily,
                  fontSize: 14,
                  fontWeight: Fonts.semiBold,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          AppConstants.defaultLocationSubtext,
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            fontSize: 11,
            fontWeight: Fonts.regular,
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.notificationBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          ImageHelper.getImagePath('bell'),
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            Colors.grey[600]!,
            BlendMode.srcIn,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

