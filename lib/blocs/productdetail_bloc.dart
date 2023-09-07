import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/services/api.dart';

// Define events
abstract class ProductDetailEvent {}

class FetchProductDetail extends ProductDetailEvent {
  final String productId;

  FetchProductDetail(this.productId);
}

// Define states
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductDetailState {
  final String error;

  ProductDetailError(this.error);
}

// Define the ProductDetailBloc
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productService = ProductRepository();

  ProductDetailBloc(String? productId) : super(ProductDetailInitial());

  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is FetchProductDetail) {
      yield ProductDetailLoading();
      try {
        final product = await productService.fetchProducts(event.productId);
        yield ProductDetailLoaded(product as Product);
      } catch (e) {
        yield ProductDetailError(e.toString());
      }
    }
  }
}
