import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:selling_electronics/core/controllers/cubits/profile_cubit/cubit.dart';
import 'package:selling_electronics/core/controllers/cubits/profile_cubit/states.dart';
import 'package:selling_electronics/core/managers/widgets/navigate.dart';
import 'package:selling_electronics/screens/widgets/custom_profile_item.dart';

import '../../../core/managers/styles/colors.dart';
import '../../../core/managers/widgets/full_screen_image.dart';
import '../../widgets/build_logout.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit , ProfileStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ProfileCubit.get(context);
        return  ConditionalBuilder(
          condition: state != GetProfileLoadingState && cubit.profileModel != null,
          builder: (context) => Scaffold(

            body:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                    imageUrl: cubit.profileModel!.user!.profileImage!,
                                    imageBuilder: (context, imageProvider) =>
                                        Image(image: imageProvider,fit: BoxFit.cover),
                                    placeholder: (context, url) => Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                        color: defaultColor,
                                        size: 50,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      print(error.toString());
                                      return Center(
                                        child: LoadingAnimationWidget.staggeredDotsWave(
                                          color: defaultColor,
                                          size: 50,
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                height: 180,
                                width: double.infinity,
                                color: defaultColor.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 150,
                          bottom: 15,
                          child: OutlinedButton(
                            onPressed: () {
                              signOut(context);
                            },
                            child:  const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'LogOut',
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.logout,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 15,
                          child: OutlinedButton(
                            onPressed: () {
                              navigateTo(context, EditProfileScreen());
                            },
                            child:  const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'edit',
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.edit,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 66.0,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(imagePath:'${cubit.profileModel!.user!.profileImage}'),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage('${cubit.profileModel!.user!.profileImage}'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomProfile(title: 'Name', body: cubit.profileModel!.user!.name!),
                  CustomProfile(title: 'Email', body: cubit.profileModel!.user!.email!),
                  CustomProfile(title: 'Phone', body: cubit.profileModel!.user!.phone!),
                  CustomProfile(title: 'NationalId', body: cubit.profileModel!.user!.nationalId!),
                  CustomProfile(title: 'Gender', body: cubit.profileModel!.user!.gender!),

                ],
              ),
            ),
          ),
          fallback: (context) =>  Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
        color: defaultColor,
        size: 50,
        ),
        ),);
      },
    );
  }
}
