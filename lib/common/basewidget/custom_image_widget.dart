import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:da3em/utill/images.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:da3em/utill/images.dart';
import 'package:provider/provider.dart';

import '../../theme/controllers/theme_controller.dart';

class CustomImageWidget extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  const CustomImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder});

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();

  static bool validateURL(String? input) {
    if (input?.isNotEmpty == true) {
      return Uri.parse(input!).host.isNotEmpty;
    } else {
      return false;
    }
  }
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  @override
  Widget build(BuildContext context) {
    var imgUrl = widget.image.replaceAll("/app/public", "").replaceAll("http://", "http://").
    replaceAll("https://da3em.net/storage", "https://da3em-s3.s3.eu-west-3.amazonaws.com");
    return Image.network(
      widget.image,
      fit: widget.fit ?? BoxFit.cover,
      height: widget.height,
      width: widget.width,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: widget.height,
          width: widget.width,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        );
      },
    );
  }
}

/*
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
      placeholder: (context, url) => Image.asset(placeholder?? Images.placeholder, height: height, width: width, fit: BoxFit.cover),
      imageUrl: image, fit: fit?? BoxFit.cover,
      height: height,width: width,
      errorWidget: (c, o, s) => Image.asset(placeholder?? Images.placeholder, height: height, width: width, fit: BoxFit.cover),

    );
  }
}
*/

