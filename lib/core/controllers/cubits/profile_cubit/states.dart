import '../../../../models/user_model.dart';

abstract class ProfileStates{}

class ProfileInitState extends ProfileStates{}


class GetProfileLoadingState extends ProfileStates{}

class GetProfileSuccessState extends ProfileStates{}

class GetProfileErrorState extends ProfileStates{}

class UpdateProfileLoadingState extends ProfileStates{}

class UpdateProfileSuccessState extends ProfileStates{
  final UserModel profileModel;
  UpdateProfileSuccessState(this.profileModel);
}

class UpdateProfileErrorState extends ProfileStates{}
