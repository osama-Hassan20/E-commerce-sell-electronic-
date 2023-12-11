import 'package:flutter/material.dart';
import 'package:selling_electronics/core/controllers/cubits/cart_cubit/cubit.dart';
import '../../core/managers/styles/colors.dart';

Widget checkoutButton({
  required double width,
  required VoidCallback? function,
  required BuildContext context,
}) =>
    FloatingActionButton.extended(
      onPressed: function,
      label: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${CartCubit.get(context).totalItem} item',),
                 Text('EGP ${CartCubit.get(context).totalPrice.toStringAsFixed(4)}',style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),
            const Spacer(),
            const Text(
              'CHECKOUT',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            const Spacer(),
            Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),

              child: const Icon(Icons.arrow_forward,color: defaultColor,),
            ),
          ],
        ),
      ),
    );
