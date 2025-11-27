import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImageWithFallback extends StatefulWidget {
  final String pngPath;
  final String svgPath;
  final double width;
  final double height;
  final BoxFit fit;

  const ProfileImageWithFallback({
    super.key,
    required this.pngPath,
    required this.svgPath,
    required this.width,
    required this.height,
    required this.fit,
  });

  @override
  State<ProfileImageWithFallback> createState() =>
      _ProfileImageWithFallbackState();
}

class _ProfileImageWithFallbackState extends State<ProfileImageWithFallback> {
  bool _pngFailed = false;

  @override
  Widget build(BuildContext context) {
    if (_pngFailed) {
      return SvgPicture.asset(
        widget.svgPath,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholderBuilder: (context) => _buildPlaceholder(),
        semanticsLabel: widget.svgPath,
      );
    }

    return Image.asset(
      widget.pngPath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        if (!_pngFailed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _pngFailed = true;
              });
            }
          });
        }
        return SvgPicture.asset(
          widget.svgPath,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          placeholderBuilder: (context) => _buildPlaceholder(),
          semanticsLabel: widget.svgPath,
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Icon(
        Icons.person,
        size: widget.width,
        color: Colors.white,
      ),
    );
  }
}

