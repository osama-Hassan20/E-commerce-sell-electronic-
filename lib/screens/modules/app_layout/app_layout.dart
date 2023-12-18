import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/controllers/cubits/app_cubit/cubit.dart';
import '../../../core/controllers/cubits/app_cubit/state.dart';
import '../../../core/managers/styles/colors.dart';
import '../../widgets/build_logout.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(cubit.titles[cubit.currentIndex],style: const TextStyle(color: Colors.black),),
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex:cubit.currentIndex ,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.home,
                    ),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'Account'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    label: 'Cart'
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
