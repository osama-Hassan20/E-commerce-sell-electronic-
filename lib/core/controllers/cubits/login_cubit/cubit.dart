import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/login_cubit/states.dart';
import '../../../../models/user_model.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? loginModel;

  void userLogin({
    required String email ,
    required String password ,

  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: EndPoint.loginApi,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value?.data);
      loginModel = UserModel.fromJson(value?.data);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print('error ====================');
      print(error.toString());
      print('error ====================');

      emit(LoginErrorState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangePasswordVisibilityState());
      }
}