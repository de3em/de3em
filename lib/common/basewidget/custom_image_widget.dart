import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:da3em/utill/images.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  const CustomImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Image.asset(placeholder ?? Images.placeholder, height: height, width: width, fit: BoxFit.cover);
      },
      imageUrl: image.replaceAll("/app/public", "").replaceAll("http://", "https://"),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      errorWidget: (c, image, s) {
        return CachedNetworkImage(
          placeholder: (context, url) {
            return Image.asset(placeholder ?? Images.placeholder, height: height, width: width, fit: BoxFit.cover);
          },
          imageUrl: image.replaceAll("https://da3em.net/storage", "https://da3em-s3.s3.eu-west-3.amazonaws.com"),
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          errorWidget: (c, image, s) {
            return Image.asset(placeholder ?? Images.placeholder, height: height, width: width, fit: BoxFit.cover);
          },
        );
        // return Image.asset(placeholder ?? Images.placeholder, height: height, width: width, fit: BoxFit.cover);
      },
    );
  }
}
