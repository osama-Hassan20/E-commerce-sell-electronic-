
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../screens/modules/login/login_screen.dart';
import '../../../managers/widgets/navigate.dart';
import '../../../network/local/cache_helper.dart';
import 'onboarding_states.dart';
class OnBoardingCubit extends Cubit<OnBoardingStates>{
  OnBoardingCubit() : super(OnBoardingInitState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isPageLast = false;
  int screenIndex = 0;
  String textButton = 'next';

  void pageLast(index){
    isPageLast = true;
    screenIndex = index;
    textButton ='Get Started';
    emit(PageLast());
  }
  void pageNotLast(index){
    isPageLast = false;
    screenIndex = index;
    textButton ='next';
    emit(NotPageLast());
  }
  void submit(context){
    CacheHelper.saveData(key:'onBoarding', value:true).then((value)=>
        navigateAndFinish(context, LoginScreen()));
  }
}