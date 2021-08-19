import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:souq/modules/onBoarding/onboarding_screen.dart';
import 'package:souq/shared/bloc_observer.dart';
import 'package:souq/shared/network/local/cache_hlper.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';
import 'package:souq/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // must be used if the main is async
  Bloc.observer = MyBlocObserver();
  DioHelper
      .init(); // init is static method belong to the class not the object &  Dio is static object
  //await CacheHelper
  //.init(); // init is static method belong to the class not the object &  SahredPrefernces is static object

  //bool? isDark = CacheHelper.getData(key: 'isDark');

  //runApp(MyApp(isDark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*final isDark;
  MyApp(this.isDark);*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
