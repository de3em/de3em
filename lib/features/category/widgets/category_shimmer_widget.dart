import 'package:flutter/material.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerWidget extends StatelessWidget {
  const CategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                for (int i in [
                  0,
                  1
                ]) ...[
                  Container(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        margin: EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: ColorResources.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                              height: 10,
                              width: 70,
                              decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
