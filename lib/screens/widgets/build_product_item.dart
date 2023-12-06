import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selling_electronics/core/managers/styles/colors.dart';
import 'package:selling_electronics/core/managers/widgets/navigate.dart';
import 'package:selling_electronics/screens/modules/products/product_details_screen.dart';

import '../../models/product_model.dart';

Widget buildProductItem(Product product, context) => InkWell(
      onTap: () {
        navigateTo(context,  ProductDetails(product: product,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // width: 180,
            // height: 300,
            //color: Colors.green,
            child: Column(
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
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20)),
                            color: defaultColor.withOpacity(0.6),
                          ),
                          height: 125,
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
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                product.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            if (product.status == 'New')
                              Expanded(
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xffC70000),
                                        borderRadius:
                                            BorderRadius.horizontal(
                                                left: Radius.circular(20))),
                                    child: const Center(
                                        child: Text(
                                      '10% OFF',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                    ),),),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          product.company!,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              decoration: const BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                // child: Text(
                                //   'Buy'.toUpperCase(),
                                //   style: const TextStyle(color: Colors.white),
                                // ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
