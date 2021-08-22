import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/models/categories_model.dart';
import 'package:souq/models/home_model.dart';
import 'package:souq/modules/categories/categories_screen.dart';
import 'package:souq/modules/favourites/favourites_screen.dart';
import 'package:souq/modules/products/products_screen.dart';
import 'package:souq/shared/components/constants.dart';
import 'package:souq/shared/cubit/home_states.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // Bottom Navigation Bar
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favourites',
    ),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    /*if (index == 1) {
      getSportsNews();
    }
    if (index == 2) {
      getScienceNews();
    }
    if (index == 3) {
      getTechnologyhNews();
    }*/
    emit(HomeChangeBottomNavigationBarState());
  }

  // Handling HomeData API
  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.status);
      //printFullText(homeModel.toString());
      emit(HomeSuccessHomeDataState());
    }).catchError((error) {
      emit(HomeErrorHomeDataState(error.toString()));
    });
  }

  // Handling HomeCategories API
  CategoriesModel? categoriesModel;
  void getHomeCategories() {
    emit(HomeLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      //printFullText(categoriesModel.toString());
      emit(HomeSuccessCategoriesState());
    }).catchError((error) {
      emit(HomeErrorCategoriesState(error.toString()));
    });
  }
}
