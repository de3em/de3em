import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentProductProvider with ChangeNotifier {
  List<Product> _recentProducts = [];
  bool _isLoading = false;

  List<Product> get recentProducts => _recentProducts;
  bool get isLoading => _isLoading;

  RecentProductProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? productStrings = prefs.getStringList('recent_products');
    print(productStrings);
    if (productStrings != null) {
      _recentProducts = productStrings
          .map((productString) => Product.fromJson(jsonDecode(productString)))
          .toList();
    }

    _isLoading = false;
    notifyListeners();
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
    List<String> recent = [];
    try {
      recent = _recentProducts
          .map((productString) => jsonEncode(productString.toJson()))
          .toList();
    } catch (e) {
      print('Error decoding JSON: $e');
    }

    await prefs.setStringList('recent_products', recent);
  }
}
