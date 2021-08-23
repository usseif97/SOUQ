import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/modules/authentication/login_screen.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/cubit/home_states.dart';
import 'package:souq/shared/network/local/cache_hlper.dart';
import 'package:souq/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: defaultColor),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: HomeCubit.get(context).userModel != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is HomeLoadingUpdateUserState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'name must not be empty';
                              }

                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person,
                            context: context,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'email must not be empty';
                              }

                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email,
                            context: context,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'phone must not be empty';
                              }

                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                            context: context,
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          defaultColoredButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                HomeCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );
                              }
                            },
                            text: 'update',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultColoredButton(
                            onTap: () {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                navigateToAndFinish(context, LoginScreen());
                              });
                            },
                            text: 'Logout',
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
