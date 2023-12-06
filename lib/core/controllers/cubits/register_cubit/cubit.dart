import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selling_electronics/core/controllers/cubits/register_cubit/states.dart';
import 'package:selling_electronics/models/user_model.dart';

import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late UserModel? registerModel;

  void userRegister({
    required String name ,
    required String email ,
    required String password ,
    required String phone ,
    required String nationalId ,

  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: EndPoint.registerApi,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
          'nationalId':nationalId,
          "gender":genderSelectedValue,
          "profileImage":userImage,
        },
    ).then((value) {
      print(value?.data);
      registerModel = UserModel.fromJson(value?.data);

      emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      print('error ====================');
      print(error.toString());
      print('error ====================');

      emit(RegisterErrorState(error.toString()));

    });
  }

  ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  Future<void> addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      print('images = $userImage');
      emit(ChooseImageState());
    } else {
      print('no image selected');
    }
  }


  String? genderSelectedValue;
  void genderSelected(value){
    genderSelectedValue = value;
    emit(GenderSelectedState());
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(RChangePasswordVisibilityState());
      }



}
