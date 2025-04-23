import 'dart:convert';
import 'package:dummyjson_ecommerce/features/home/models/category_models.dart';
import 'package:dummyjson_ecommerce/features/home/models/product_models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  //Products
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products?limit=100'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['products'];
    } else {
      throw Exception('Error !! Ocursed!! Not found Products');
    }
  }

  //Categories
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> categoriesList = json.decode(response.body);

      return categoriesList
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Search Products
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/search?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsData = data['products'];
      return productsData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }

  //Fetch Products By Category
  Future<List<ProductModel>> fetchProductsByCategory(
    String categorySlug,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/category/$categorySlug'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsData = data['products'];
      return productsData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch products by category');
    }
  }
}
