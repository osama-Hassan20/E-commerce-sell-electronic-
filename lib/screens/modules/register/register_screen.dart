import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/managers/variables/images.dart';
import '../../../core/controllers/cubits/register_cubit/cubit.dart';
import '../../../core/controllers/cubits/register_cubit/states.dart';
import '../../../core/managers/widgets/default_button.dart';
import '../../../core/managers/widgets/default_text_button.dart';
import '../../../core/managers/widgets/default_text_form_field.dart';
import '../../../core/managers/widgets/navigate.dart';
import '../../../core/managers/widgets/show_toast.dart';
import '../../../core/managers/variables/values.dart';
import '../../../core/network/local/cache_helper.dart';
import '../app_layout/app_layout.dart';
import '../products/prducts_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalIdController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status == 'success') {
              showToast(
                  text: state.registerModel.message!,
                  state: ToastState.SUCCESS);

              CacheHelper.saveData(
                      key: 'userId',
                      value: state.registerModel.user!.nationalId)
                  .then((value) {
                nationalId = state.registerModel.user!.nationalId;
              });
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.user!.token,
              ).then((value) {
                token = state.registerModel.user!.token;
                print('token token = $token');
                navigateAndFinish(context,  const AppLayout());
              });
            } else {
              print(state.registerModel.message);
              showToast(
                  text: state.registerModel.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.registerImage),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 35, top: size.height * 0.09, right: 35),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create\nAccount',
                            style: TextStyle(color: Colors.white, fontSize: 33),
                          ),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () {
                              cubit.addImage();
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: ClipOval(
                                    child: cubit.image == null
                                        ? Container(
                                            decoration:  BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(AppImages.noUserImage),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(cubit.image!),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 14,
                                  backgroundColor:
                                  Color(0xfff0e0d0),
                                  child: Icon(
                                    Icons
                                        .camera_alt,
                                    color: Colors
                                        .black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  label: 'User Name',
                                  prefix: Icons.person,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your name';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  label: 'Email Address',
                                  prefix: Icons.email_outlined,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your email address';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: RegisterCubit.get(context).suffix,
                                  onSubmit: (value) {},
                                  isPassword:
                                      RegisterCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    RegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'password is too short';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  label: 'phone',
                                  prefix: Icons.phone,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your phone';
                                    }else if(value.length != 11){
                                      return 'The Phone must be 11 number';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: nationalIdController,
                                  type: TextInputType.phone,
                                  label: 'National Id',
                                  prefix: Icons.info_outline,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your phone';
                                    }else if(value.length != 14){
                                      return 'The Phone must be 14 number';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        "Gender",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: "male",
                                            groupValue: cubit.genderSelectedValue,
                                            onChanged: (value) {
                                              cubit.genderSelected(value);
                                            },
                                          ),
                                          const Text(
                                            "Male",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: "female",
                                            groupValue: cubit.genderSelectedValue,
                                            onChanged: (value) {
                                              cubit.genderSelected(value);
                                            },
                                          ),
                                          const Text(
                                            "Female",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => defaultButton(
                                    function: () {
                                      CacheHelper.removeDate(key: 'token');
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          nationalId: nationalIdController.text,
                                        );
                                      }
                                    },
                                    text: 'register',
                                    isUpperCase: true,
                                  ),
                                  fallback: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                              const SizedBox(
                                height:10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  defaultTextButton(
                                    function: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'Login ->',
                                  ),
                                  const SizedBox(
                                    height:10,
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
