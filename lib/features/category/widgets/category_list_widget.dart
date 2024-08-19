import 'package:flutter/material.dart';
import 'package:da3em/features/category/controllers/category_controller.dart';
import 'package:da3em/features/category/domain/models/category_model.dart';
import 'package:da3em/features/category/widgets/category_widget.dart';
import 'package:da3em/features/product/screens/brand_and_category_product_screen.dart';
import 'package:da3em/localization/controllers/localization_controller.dart';
import 'package:provider/provider.dart';

import 'category_shimmer_widget.dart';

class CategoryListWidget extends StatelessWidget {
  final bool isHomePage;
  const CategoryListWidget({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.isNotEmpty
            ? SizedBox(
                height: 210,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: (categoryProvider.categoryList.length/2).ceil(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(

                      children: [
                        // _item(context, categoryProvider, index),
                        // _item(context, categoryProvider, index + 1),
                            SizedBox(
                              height: 105,
                              child: _item(context, categoryProvider, index * 2)),
                            SizedBox(
                              height: 105,
                              child: _item(context, categoryProvider, index * 2 + 1)),
                      ],
                    );
                  },
                ),
              )
            : const CategoryShimmerWidget();
      },
    );
  }

  Widget _item(BuildContext context, CategoryController categoryProvider, int index) {
    final CategoryModel? category = categoryProvider.categoryList.length > index ? categoryProvider.categoryList[index] : null;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BrandAndCategoryProductScreen(
              isBrand: false,
              id: category?.id.toString(),
              name: category?.name,
            ),
          ),
        );
      },
      child: CategoryWidget(
        category: category,
        index: index,
        length: categoryProvider.categoryList.length,
      ),
    );
  }
}
