import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart ' as http;
import 'package:shopping_app/models/product_model.dart';

// Define events
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {} // Define FetchProducts event

// Define states
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}

// Define the ProductBloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final http.Client httpClient;
  

  ProductBloc(this.httpClient, {required }) : super(ProductInitial()) {
    // Register event handlers in the constructor
    on<FetchProducts>((event, emit)async {
       await _handleFetchProducts(event, emit);
      // Handle the FetchProducts event here
      _handleFetchProducts(event, emit);
    });
  }

  Future<void> _handleFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
  try {
    emit(ProductLoading());

    final List<Product> products = await fetchProducts(); // Fetch the data
    emit(ProductLoaded(products)); // Emit the loaded state with the data
  } catch (e) {
    emit(ProductError(e.toString())); // Handle and emit an error state if there's an exception
  }
}




  Future<List<Product>> fetchProducts() async {
    final response = await httpClient.get(Uri.parse('https://fakestoreapi.com/products'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}


