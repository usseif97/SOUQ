import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/home_layout.dart';
import 'package:souq/modules/authentication/register_screen.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/login_cubit.dart';
import 'package:souq/shared/cubit/login_states.dart';
import 'package:souq/shared/network/local/cache_hlper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              // Login Success
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateToAndFinish(context, HomeLayout());
              });
            } else {
              // Login Fall
              showSnackBar(
                context: context,
                content: state.loginModel.message,
                label: 'Error',
                state: snackBarStates.ERROR,
              );
            }
          } else if (state is LoginErrorState) {
            showSnackBar(
              context: context,
              content: 'Network Error !!',
              label: 'Error',
              state: snackBarStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browse our offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        SizedBox(height: 30),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty)
                              return 'Please Enter your Email address !!';
                          },
                          radius: 50.0,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          context: context,
                        ),
                        SizedBox(height: 15),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty)
                              return 'your password is too short !!';
                          },
                          radius: 50.0,
                          isPassword: LoginCubit.get(context).isPassword,
                          label: 'Password',
                          prefix: Icons.lock_clock_outlined,
                          context: context,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibilty();
                          },
                        ),
                        SizedBox(height: 30),
                        state is LoginLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',
                                isUpperCase: true,
                                radius: 50.0,
                              ),
                        SizedBox(height: 15),
                        Center(
                          child: Row(
                            children: [
                              Text('Don\'t have an account ?!'),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'register',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
