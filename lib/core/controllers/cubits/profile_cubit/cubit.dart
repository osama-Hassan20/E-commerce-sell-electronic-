import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/profile_cubit/states.dart';
import 'package:selling_electronics/core/managers/variables/values.dart';
import 'package:selling_electronics/models/user_model.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel? profileModel;

  void getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.postData(url: EndPoint.userProfileApi, data: {
      'token': token,
    }).then((value) {
      profileModel = UserModel.fromJson(value!.data);
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }


  UserModel? editProfileModel;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: EndPoint.updateUserProfileApi, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
      "gender": profileModel!.user!.gender,
      "password": '123456789',
      "token": token
    }).then((value) {
      editProfileModel = UserModel.fromJson(value!.data);
      print(editProfileModel!.user!.name);
      getProfile();
      emit(UpdateProfileSuccessState(editProfileModel!));
    }).catchError((error) {
      emit(UpdateProfileErrorState());
      print(error.toString());
    });
  }
}
