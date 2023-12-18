import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:selling_electronics/core/managers/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/product_model.dart';

class BuildProductDetailsItem extends StatelessWidget {
   BuildProductDetailsItem({Key? key, required this.product}) : super(key: key);
  Product product;

  @override
  Widget build(BuildContext context) {
    var boardController = PageController();
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.3,
            child: Stack(
              children: [
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemCount: product.images!.length,
                  itemBuilder: (context, index) => CachedNetworkImage(
                      imageUrl: product.images![index],
                      imageBuilder: (context, imageProvider) =>
                          Image(image: imageProvider),
                      placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: defaultColor,
                            size: 50,
                          ),),
                      errorWidget: (context, url, error) {
                        print(error.toString());
                        return  Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: defaultColor,
                            size: 50,
                          ),
                        );
                      }),
                ),
                Text(
                  product.status!,
                  style: TextStyle(
                      fontSize: 24,
                      backgroundColor: defaultColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Center(
            child: SmoothPageIndicator(
              controller: boardController,
              count: product.images!.length,
              effect: const ExpandingDotsEffect(
                  activeDotColor: defaultColor,
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 1.5,
                  dotWidth: 10,
                  spacing: 10),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                      text: product.name!,

                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: product.company!,
                          style: TextStyle(
                              fontSize: 14,
                              backgroundColor: defaultColor.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),

              Text(
                '\$${product.price}',
                style: const TextStyle(
                    color: defaultColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Description',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          Text(
            '${product.description}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
