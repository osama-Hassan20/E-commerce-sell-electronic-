import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/on_bording_model.dart';

Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children:  [
    Expanded(
        child: SvgPicture.asset(
          model.image,
          fit: BoxFit.fill,
          // width: double.infinity,
        )
    ),
    const SizedBox(
      height: 20,
    ),
    Text(
      model.title,
      style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold
      ),
    ),
    const SizedBox(
      height: 15,
    ),
    Text(
      model.body,
      style: const TextStyle(
        fontSize: 24,
      ),
      textAlign: TextAlign.center,
    ),
  ],
);
