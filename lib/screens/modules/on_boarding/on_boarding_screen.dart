import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:selling_electronics/core/controllers/cubits/onboarding_cubit/onboarding_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/managers/styles/colors.dart';
import '../../../core/managers/widgets/default_button.dart';
import '../../../core/managers/widgets/default_text_button.dart';
import '../../widgets/boarding_item.dart';
import '../../widgets/boarding_list.dart';




class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context) => OnBoardingCubit() ,
      child: BlocConsumer<OnBoardingCubit , OnBoardingStates>(
        listener:(context,state){},
        builder:(context,state){
          var boardController = PageController();
          var cubit = OnBoardingCubit.get(context);

          return Scaffold(
              backgroundColor: const Color(0xffffffff),
              appBar: AppBar(
                actions: [
                  defaultTextButton(
                      function:(){
                        cubit.submit(context);
                      },
                      text: 'skip')
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(30) ,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller:  boardController ,
                        onPageChanged:(index){
                          if(index==boarding.length-1){
                            cubit.pageLast(index);
                          }else{
                            cubit.pageNotLast(index);
                          }
                        },
                        itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                        itemCount:boarding.length ,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect:  const ExpandingDotsEffect(
                          activeDotColor: defaultColor,
                          dotColor: Colors.grey,
                          dotHeight: 15,
                          expansionFactor: 3,
                          dotWidth: 20,
                          spacing: 6

                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultButton(
                      function: () {
                        if (cubit.isPageLast) {
                          cubit.submit(context);
                        } else {
                          boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeInOutCubicEmphasized,
                          );
                        }
                      },
                      text: cubit.textButton,
                      isUpperCase: true,
                    ),

                  ],
                ),
              )
          );
        },
      ),
    );
  }
}