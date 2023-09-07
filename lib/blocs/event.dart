// product_event.dart
import 'package:shopping_app/models/product_model.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

// product_state.dart
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);

  List<Object> get props => [error];
}
