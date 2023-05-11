import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/config.dart';
import '../../helper/utils.dart';


class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  ///[ImageLoader] is a widget to load image from network or asset
  ///
  ///[imageUrl] is required, SVG image is **supported**
  ///
  ///if [imageUrl] is a network image, it must be a **full url**
  ///
  ///example: https://example.com/image.png
  ///
  ///[fit] is optional, default is [BoxFit.cover]
  ///
  ///example:
  ///
  ///```dart
  ///ImageLoader(
  ///  'https://example.com/image.png',
  ///   fit: BoxFit.cover,
  /// ),
  /// ```
  const ImageLoader(
    this.imageUrl, {
    super.key,
    this.fit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) {
    if (utils.getFileExtension(imageUrl) == 'svg') {
      if (!(imageUrl.contains('http'))) {
        return SvgPicture.asset(
          imageUrl,
          fit: fit,
        );
      } else {
        return SvgPicture.network(
          imageUrl,
          fit: fit,
        );
      }
    } else {
      if (!(imageUrl.contains('http'))) {
        return Image.asset(
          imageUrl,
          fit: fit,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          progressIndicatorBuilder: (context, child, loadingProgress) {
            return Center(
              child: CircularProgressIndicator(
                color: App.theme.colors.primary.yellow,
                value: loadingProgress.progress,
              ),
            );
          },
        );
      }
    }
  }

  /// [ImageLoader] return a [ImageProvider], which can be used in [Image] widget
  /// 
  /// [imageUrl] is required, SVG image is **NOT** supported
  /// 
  static ImageProvider provider(
    String imageUrl,
  ) {
    if (imageUrl.isEmpty) {
      return const AssetImage('assets/images/placeholder.png');
    } else {
      final url = imageUrl;
      if (utils.getFileExtension(imageUrl) == 'svg') {
        return const AssetImage('assets/images/placeholder.png');
      } else {
        return CachedNetworkImageProvider(
          url,
        );
      }
    }
  }
}
