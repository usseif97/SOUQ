import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:souq/modules/Profile/profile_screen.dart';
import 'package:souq/modules/search/search_screen.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/cubit/home_states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                'SOUQ',
                style: GoogleFonts.mcLaren(),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, ProfileScreen());
                },
                icon: Icon(
                  Icons.account_circle,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          /*Center(
            child: TextButton(
              onPressed: () {
                CacheHelper.removeData(key: 'token').then((value) {
                  navigateToAndFinish(context, LoginScreen());
                });
              },
              child: Text('SignOut'),
            ),
          ),*/
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
