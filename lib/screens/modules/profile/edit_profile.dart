import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/managers/widgets/show_toast.dart';

import '../../../core/controllers/cubits/profile_cubit/cubit.dart';
import '../../../core/controllers/cubits/profile_cubit/states.dart';
import '../../../core/managers/widgets/default_button.dart';
import '../../../core/managers/widgets/default_text_form_field.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context,state) {
        if(state is UpdateProfileSuccessState){
          showToast(
              text: state.profileModel.message!, state: ToastState.SUCCESS);
          Navigator.pop(context);
        }
          
      },
      builder: (context,state) {
        var model = ProfileCubit.get(context).profileModel;
        nameController.text = model!.user!.name!;
        emailController.text = model.user!.email!;
        phoneController.text = model.user!.phone!;
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: ProfileCubit.get(context).profileModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is UpdateProfileLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }else{
                          return null;
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'email must not be empty';
                        }else{
                          return null;
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'phone must not be empty';
                        }else{
                          return null;
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate())
                        {
                          ProfileCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: 'update',
                    ),
                  ],
                ),
              ),
            ),
            fallback:(context) => Center(child: CircularProgressIndicator()) ,
          ),
        );

      },

    );
  }
}