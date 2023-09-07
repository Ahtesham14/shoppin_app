import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shopping_app/models/product_model.dart'; // Add this import for json.decode

class ProductRepository {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      // Parse JSON response and return a list of Product objects.
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Product> products = jsonData.map((json) {
        return Product.fromJson(json);
      }).toList();
      
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
