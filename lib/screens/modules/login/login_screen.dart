import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/managers/variables/images.dart';
import 'package:selling_electronics/screens/modules/products/prducts_screen.dart';
import 'package:selling_electronics/screens/modules/register/register_screen.dart';
import '../../../core/controllers/cubits/login_cubit/cubit.dart';
import '../../../core/controllers/cubits/login_cubit/states.dart';
import '../../../core/managers/widgets/default_button.dart';
import '../../../core/managers/widgets/default_text_button.dart';
import '../../../core/managers/widgets/default_text_form_field.dart';
import '../../../core/managers/widgets/navigate.dart';
import '../../../core/managers/widgets/show_toast.dart';
import '../../../core/managers/variables/values.dart';
import '../../../core/network/local/cache_helper.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == 'success') {
              showToast(
                  text: state.loginModel.message!, state: ToastState.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.user?.token,
              ).then((value) {
                token = state.loginModel.user!.token!;
                navigateAndFinish(context, const ProductScreen());
              });
            }
            else {
              showToast(
                  text: state.loginModel.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.loginImage),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only( top: size.height * 0.09),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to\nSell Electronic',
                          style: TextStyle(color: Colors.white, fontSize: 33),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: size.height * 0.45),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                height: 20,
                              ),
                              defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: LoginCubit.get(context).suffix,
                                  isPassword:
                                      LoginCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your password';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder:(context) => defaultButton(
                                    function:(){
                                      if(formKey.currentState!.validate()){
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,);
                                      }

                                    },
                                    text: 'login',
                                    isUpperCase: true,

                                  ),
                                  fallback:(context) => const CircularProgressIndicator() ,
                                ),
                              ),


                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  defaultTextButton(
                                      function: () {
                                        navigateTo(context,  RegisterScreen());
                                      },
                                      text: 'Register',
                                  ),
                                  defaultTextButton(
                                    function: () {},
                                    text: 'Forgot Password',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
