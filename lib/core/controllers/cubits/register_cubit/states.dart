

import 'package:selling_electronics/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final UserModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}

class ChooseImageState extends RegisterStates{}


class RChangePasswordVisibilityState extends RegisterStates{}

class GenderSelectedState extends RegisterStates{}
