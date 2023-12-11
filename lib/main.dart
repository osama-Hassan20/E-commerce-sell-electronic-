import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/blocobserver.dart';
import 'package:selling_electronics/core/controllers/cubits/app_cubit/cubit.dart';
import 'package:selling_electronics/core/controllers/cubits/cart_cubit/cubit.dart';
import 'package:selling_electronics/screens/modules/app_layout/app_layout.dart';
import 'package:selling_electronics/screens/modules/login/login_screen.dart';
import 'package:selling_electronics/screens/modules/on_boarding/on_boarding_screen.dart';
import 'core/controllers/cubits/favorite_cubit/cubit.dart';
import 'core/controllers/cubits/product_cubit/cubit.dart';
import 'core/managers/styles/themes.dart';
import 'core/managers/variables/values.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  boarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key:'token');
  nationalId = CacheHelper.getData(key:'userId');
  if (kDebugMode) {
    print('token$token');
    print('nationalId$nationalId');
    print('boarding$boarding');
  }

  if(boarding != null ){
    if(token != null) {
      startWidget = const AppLayout();
    }else{
      startWidget = LoginScreen();
    }
  }else{
    startWidget = OnBoardingScreen();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const SellingElectronics());
}

class SellingElectronics extends StatelessWidget {
  const SellingElectronics({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>ProductCubit()..getHomeProducts()
        ),
        BlocProvider(
            create: (BuildContext context) =>AppCubit()
        ),
        BlocProvider(
            create: (BuildContext context) =>CartCubit()..getCart(),
        ),
        BlocProvider(
            create: (BuildContext context) =>FavoriteCubit()..getFavorites(),
        ),
      ],
      child: MaterialApp(
        title: 'Selling Electronic',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home:  startWidget,
      ),
    );
  }
}
