import 'package:flutter/material.dart';
import 'package:selling_electronics/screens/widgets/build_logout.dart';
import 'package:selling_electronics/screens/widgets/build_product_details_item.dart';
import '../../../core/managers/styles/colors.dart';
import '../../../models/product_model.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key, required this.product}) : super(key: key);
  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.favorite_border,
                  color: defaultColor,
                  size: 32,
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Add to cart'),
      ),
      body: BuildProductDetailsItem(product: product)
    );
  }
}
