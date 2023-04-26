import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView({
    Key? key,
    required this.fileName,
    this.height,
    this.width,
    this.color,
    this.scale,
    this.fit,
  }) : super(key: key);

  final String fileName;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    String mimType = fileName.split(".").last;

    if (mimType.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case "svg":
        return SvgPicture.asset(
          fileName,
          height: height,
          width: width,
          color: color,
          fit: fit ?? BoxFit.scaleDown,
        );
      case "png":
      case "jpg":
      case "jpeg":
        return Image.asset(
          fileName,
          height: height,
          width: width,
          scale: scale,
          fit: fit ?? BoxFit.scaleDown,
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}
