import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/app_cubit/state.dart';

import '../../../../screens/modules/cart/cart_screen.dart';
import '../../../../screens/modules/favorite/favorite_screen.dart';
import '../../../../screens/modules/products/prducts_screen.dart';
import '../../../../screens/modules/profile/profile_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super (AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    const ProductScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
    const CartScreen(),
  ];

  List<String> titles =
  [
    'Products',
    'Favorite',
    'Account',
    'Cart',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNaveState());
  }

}