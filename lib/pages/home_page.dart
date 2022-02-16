import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:validation_app/models/models.dart';
import 'package:validation_app/pages/loading_page.dart';
import 'package:validation_app/services/products_service.dart';
import 'package:validation_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) {
      return const LoadingPage();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (_, index) => GestureDetector(
          child: ProductCard(product: productsService.products[index]),
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = Product(
            available: true,
            name: '',
            price: 0
          );

          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }

}
