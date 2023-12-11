import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/product_cubit/cubit.dart';
import 'package:selling_electronics/core/managers/styles/colors.dart';
import 'package:selling_electronics/core/managers/widgets/navigate.dart';
import 'package:selling_electronics/screens/modules/products/product_details_screen.dart';

import '../../core/controllers/cubits/cart_cubit/cubit.dart';
import '../../core/controllers/cubits/cart_cubit/states.dart';
import '../../core/controllers/cubits/favorite_cubit/cubit.dart';
import '../../core/controllers/cubits/favorite_cubit/state.dart';
import '../../core/managers/variables/values.dart';
import '../../models/product_model.dart';

Widget buildProductItem(dynamic product, context) => InkWell(
      onTap: () {
        navigateTo(context,  ProductDetails(product: product,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              children: [
            Expanded(

              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20))),
                      // height: 125,
                      child: Center(
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              product.status!,
                              style: const TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20)),
                            color: defaultColor.withOpacity(0.6),
                          ),
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left: 10),
                            child: CachedNetworkImage(
                                imageUrl: product.image!,
                                imageBuilder: (context, imageProvider) =>
                                    Image(image: imageProvider),
                                placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                errorWidget: (context, url, error) {
                                  print(error.toString());
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(flex:2,child: SizedBox(height: 15,)),
                            Expanded(
                              child: Container(
                                height: 15,
                                decoration: const BoxDecoration(
                                    color: Color(0xffC70000),
                                    borderRadius:
                                    BorderRadius.horizontal(
                                        left: Radius.circular(20))),
                                child:  Center(
                                  child: Text(
                                    product.status!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold),
                                  ),),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          product.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Expanded(flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                const Text(
                                  'EGP ',
                                  style:
                                      TextStyle( fontSize: 12,fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${(product.price - product.sales).toStringAsFixed(3)}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          if(product.sales !=0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '${product.price}',
                                  style:  const TextStyle(decoration: TextDecoration.lineThrough,
                                      color: Colors.grey, fontSize: 12,),
                                ),
                                const SizedBox(width: 5,),
                                Text(
                                  '${(100-((product.price-product.sales)/product.price)*100).toStringAsFixed(2)} OFF',
                                  style:  const TextStyle(
                                    color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: BlocBuilder<CartCubit , CartStates>(
                                  builder:(context,state){
                                    return MaterialButton(
                                      onPressed: () {
                                        CartCubit.get(context).cartModel!.products!.any((element) => element.sId == product.sId)?
                                        CartCubit.get(context).deleteCart(product.sId,1,product.price):
                                        CartCubit.get(context).addToCart(product.sId,product.price);
                                        ProductCubit.get(context).getHomeProducts();
                                        CartCubit.get(context).getCart();
                                      },
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                          const Spacer(),
                                          CartCubit.get(context).cartModel!.products!.any((element) => element.sId == product.sId)?
                                          const Text('Remove from cart',style: TextStyle(color: Colors.white,fontSize: 12),):
                                          const Text('Add to cart',style: TextStyle(color: Colors.white,fontSize: 12),),
                                          const Spacer(),
                                        ],
                                      ),
                                    );
                                  }

                                ),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
              ],
            ),
                BlocBuilder<FavoriteCubit , FavoriteStates>(
                builder:(context,state){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: (){
                        FavoriteCubit.get(context).favoritesModel!.favoriteProducts!.any((element) => element.sId == product.sId)?
                        FavoriteCubit.get(context).deleteFavorites(product.sId):
                        FavoriteCubit.get(context).addFavorites(product.sId);
                      },
                      child:

                      Icon(
                        FavoriteCubit.get(context).favoritesModel!.favoriteProducts!.any((element) => element.sId == product.sId)?
                        Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  );
                }
             ),
//       ShopCubit.get(context).favorites[model!.id]! ? Icons.favorite : Icons.favorite_border,
          ],
        ),
      ),
    );
