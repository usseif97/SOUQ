import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/home_layout.dart';
import 'package:souq/modules/authentication/login_screen.dart';
import 'package:souq/modules/onBoarding/onboarding_screen.dart';
import 'package:souq/shared/bloc_observer.dart';
import 'package:souq/shared/components/constants.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/network/local/cache_hlper.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';
import 'package:souq/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // must be used if the main is async
  Bloc.observer = MyBlocObserver();
  DioHelper
      .init(); // init is static method belong to the class not the object &  Dio is static object
  await CacheHelper
      .init(); // init is static method belong to the class not the object &  SahredPrefernces is static object

  //bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget startWidget = OnBoardingScreen();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print('TOKEN: $token');

  if (onBoarding != null) {
    if (token != null)
      startWidget = HomeLayout();
    else
      startWidget = LoginScreen();
  }

  //runApp(MyApp(isDark));
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  //final isDark;
  final startWidget;
  MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // App Theme Provider
          create: (context) => HomeCubit()
            ..getHomeData()
            ..getHomeCategories()
            ..getUserData(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
