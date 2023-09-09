import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/product_bloc.dart';
import 'package:shopping_app/screen/product_details.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            print("DATA IS WORKING");
            productBloc.add(FetchProducts());
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
           //var imageUrl =products.im
            print(products.length);

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                  product.image,
                  height: 200,
                              ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    onTap: () {
                      // Navigate to the product detail screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
