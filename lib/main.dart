import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/blocs/product_bloc.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/screen/product_details.dart';
import 'package:shopping_app/screen/product_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  print("App working");
  final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  ProductListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return  ProductDetailScreen(Product as Product);
          },
        ),
      ],
    ),
  ],
  navigatorKey: GlobalKey<NavigatorState>(),
);

runApp(
    BlocProvider(
      create: (context) => ProductBloc(http.Client(), ), // Provide the ProductBloc
      child: MaterialApp.router(
        routerConfig: _router,
        
        
        theme: ThemeData(
          // Define your app's theme here
        ),
      ),
    ),
  );

  // runApp(
  //    BlocProvider(
  //     create: (context) => ProductBloc(http.Client()), /
  //   MaterialApp.router(
  //      routerConfig: _router,
  //     //routeInformationParser: router.routeInformationParser,
  //   ),
  // );
}
