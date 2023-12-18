import 'package:flutter/material.dart';
import 'package:selling_electronics/core/controllers/cubits/app_cubit/cubit.dart';

import '../../core/managers/widgets/navigate.dart';
import '../../core/network/local/cache_helper.dart';
import '../../screens/modules/login/login_screen.dart';

void signOut(context) {
  CacheHelper.removeDate(key: 'token',).then((value) {
    if(value!){
      navigateAndFinish(context, LoginScreen());
      AppCubit.get(context).currentIndex = 0;
    }
  });
}

