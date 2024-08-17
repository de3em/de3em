import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentProductProvider with ChangeNotifier {
  List<Product> _recentProducts = [];
  bool _isLoading = false;
  List<Product>? currentProducts = [];

  List<Product> get recentProducts => _recentProducts;
  bool get isLoading => _isLoading;

  RecentProductProvider(BuildContext context) {
    loadProducts(context);
  }

  Future<void> loadProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productStrings = prefs.getStringList('recent_products');
    await Provider.of<ProductController>(context, listen: false)
        .getLProductList("1");

    currentProducts =
        Provider.of<ProductController>(context, listen: false).lProductList;
    if (productStrings != null) {
      List<Product> recentProductsforNow = [];
      for (var i = 0; i < productStrings.length; i++) {
        for (var j = 0; j < currentProducts!.length; j++) {
          if (currentProducts![j].id == jsonDecode(productStrings[i])['id']) {
            recentProductsforNow.add(currentProducts![j]);
          }
        }
      }

      _recentProducts = removeDuplicates(recentProductsforNow);
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Product> removeDuplicates(List<Product> products) {
    Set<String> uniqueProductIds = {};
    List<Product> uniqueProducts = [];

    for (var product in products) {
      if (!uniqueProductIds.contains(product.id.toString())) {
        uniqueProducts.add(product);
        uniqueProductIds.add(product.id.toString());
      }
    }

    return uniqueProducts;
  }

  Future<void> addProduct(Product product) async {
    _recentProducts.add(product);
    await saveProducts();
    notifyListeners();
  }

  Future<void> removeProduct(int index) async {
    _recentProducts.removeAt(index);
    await saveProducts();
    notifyListeners();
  }

  Future<void> saveProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String> productStrings = _recentProducts.map((product) {
        return jsonEncode({
          "id": product.id,
        });
      }).toList();
      print(productStrings);
      prefs.setStringList('recent_products', productStrings);
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }
}
