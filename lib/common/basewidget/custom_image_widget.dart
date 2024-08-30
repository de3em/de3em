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
    var imgUrl = image.replaceAll("/app/public", "").replaceAll("http://", "https://").replaceAll("https://da3em.net/storage", "https://da3em-s3.s3.eu-west-3.amazonaws.com");
    return CachedNetworkImage(
      key: ValueKey(imgUrl),
      placeholder: (context, url) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              // child: Center(
              //   child: Icon(Icons.error, color: Colors.grey[300]),
              // ),
            );
      },
      imageUrl: imgUrl,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
          errorWidget: (c, image, s) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              // child: Center(
              //   child: Icon(Icons.error, color: Colors.grey[300]),
              // ),
            );
            return Image.asset(placeholder ?? Images.placeholder, height: height, width: width, fit: BoxFit.cover);
          },
    );
  }
}
