import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/cart_cubit/states.dart';
import 'package:selling_electronics/core/managers/variables/values.dart';
import 'package:selling_electronics/core/network/end_point.dart';

import '../../../../models/cart_model.dart';
import '../../../network/remote/dio_helper.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitState());

  static CartCubit get(context) => BlocProvider.of(context);

  num totalItem=0;
  double totalPrice=0;


  void addToCart(productId,price) {
    DioHelper.postData(url: EndPoint.addCartApi, data: {
      "nationalId": nationalId,
      "productId": productId,
      "quantity": "1"
    }).then((value) {
      totalItem += 1;
      totalPrice+=price;
      emit(AddToCartSuccessState());
      getCart();
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartErrorState());
    });
  }

  CartModel? cartModel;

  void getCart() {
    // totalItem = 0;
    // totalPrice = 0;
    emit(GetCartLoadingState());
    DioHelper.getData(url: EndPoint.getCartApi, data: {
      "nationalId": nationalId,
    }).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(cartModel!.products!.length);
      // ignore: avoid_function_literals_in_foreach_calls
      // cartModel!.products!.forEach((element) {
        // totalItem += element.quantity;
        // totalPrice += element.totalPrice;
      // });
      print(cartModel!.products![1].quantity);
      emit(GetCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorState());
    });
  }

  void deleteCart(productId,quantity,price) {
    DioHelper.deleteData(url: EndPoint.deleteCartApi, data: {
      "nationalId": nationalId,
      "productId": productId,
    }).then((value) {
      emit(DeleteCartSuccessState());
      totalItem -= quantity;
      totalPrice -=price;
      getCart();
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCartErrorState());
    });
  }

  void updateQuantity(quantity, productId,price) {
    DioHelper.putData(url: EndPoint.updateCartApi, data: {
      "nationalId": nationalId,
      "productId": productId,
      "quantity": quantity,
    }).then((value) {
      emit(UpdateCartSuccessState());
      totalItem -= 1;
      totalPrice-=price;
      getCart();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateCartErrorState());
    });
  }
}
