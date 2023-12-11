import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_electronics/core/managers/widgets/default_button.dart';

import '../../../core/controllers/cubits/cart_cubit/cubit.dart';
import '../../../core/controllers/cubits/cart_cubit/states.dart';
import '../../widgets/build_cart_item.dart';
import '../../widgets/check_out.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        final Size size = MediaQuery.of(context).size;

        if (cubit.cartModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          backgroundColor: Colors.grey[200],
          floatingActionButton:
              checkoutButton(width: size.width - 75, function: () {},context: context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (cubit.cartModel!.products!.isNotEmpty)
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildCartItem(
                            cubit.cartModel!.products![index], context,
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 30,
                            ),
                        itemCount: cubit.cartModel!.products!.length,),
                  if (cubit.cartModel!.products!.isEmpty)
                    const Center(
                      child: Text(
                        'Cart Is Empty',
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
