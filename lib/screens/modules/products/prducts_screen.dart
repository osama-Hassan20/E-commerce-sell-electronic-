import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/favorite_cubit/cubit.dart';
import 'package:selling_electronics/core/controllers/cubits/favorite_cubit/state.dart';
import '../../../core/controllers/cubits/cart_cubit/cubit.dart';
import '../../../core/controllers/cubits/cart_cubit/states.dart';
import '../../../core/controllers/cubits/product_cubit/cubit.dart';
import '../../../core/controllers/cubits/product_cubit/states.dart';
import '../../widgets/build_product_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit,ProductStates>(
      listener:(context,state){},builder:(context,state){
      var cubit  = ProductCubit.get(context);
      // ignore: unrelated_type_equality_checks
      if(cubit.laptopsModel==null && CartCubit.get(context).state != GetCartSuccessState && FavoriteCubit.get(context).state != GetFavoritesSuccessState ){
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        body:SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: GridView.count(
                childAspectRatio: 1 / 1.6,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                    cubit.laptopsModel!.product!.length,
                        (index) =>
                        buildProductItem(cubit.laptopsModel!
                            .product![index],context)),
              ),
            ),
          ],
        ),),
      );
    },
    );
  }
}