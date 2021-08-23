import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/models/categories_model.dart';
import 'package:souq/models/change_favourites_model.dart';
import 'package:souq/models/home_model.dart';
import 'package:souq/models/login_model.dart';
import 'package:souq/modules/cart/cart_screen.dart';
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
    CartScreen(),
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
    BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart_outlined,
      ),
      label: 'My Cart',
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
  Map<int, bool>? favourites = {};
  Map<int, bool>? carts = {};
  void getHomeData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // fill favourites
      homeModel!.data.products.forEach((element) {
        favourites!.addAll({
          element.id: element.inFavorites,
        });
      });
      // fill carts
      homeModel!.data.products.forEach((element) {
        carts!.addAll({
          element.id: element.inCart,
        });
      });
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
      //print(categoriesModel!.status);
      //printFullText(categoriesModel.toString());
      emit(HomeSuccessCategoriesState());
    }).catchError((error) {
      emit(HomeErrorCategoriesState(error.toString()));
    });
  }

  // Handling Favourites without API
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productID) {
    emit(HomeSuccessChangeFavouritesState());

    homeModel!.data.products.forEach((element) {
      if (element.id == productID) element.inFavorites = !element.inFavorites;
    });

    homeModel!.data.products.forEach((element) {
      favourites!.addAll({
        element.id: element.inFavorites,
      });
    });
    //print(favourites.toString());
  }

  // Handling Cart without API
  void changeCart(int productID) {
    emit(HomeSuccessChangeCartState());
    homeModel!.data.products.forEach((element) {
      if (element.id == productID) element.inCart = !element.inCart;
    });

    homeModel!.data.products.forEach((element) {
      carts!.addAll({
        element.id: element.inCart,
      });
    });
    //print(favourites.toString());
  }

  // Handling Profile API
  LoginModel? userModel;
  void getUserData() {
    emit(HomeLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      //print(value.data);
      userModel = LoginModel.fromJson(value.data);
      emit(HomeSuccessUserDataState());
    }).catchError((error) {
      emit(HomeErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(HomeLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //printFullText(userModel!.data.name);
      emit(HomeSuccessUpdateUserState());
    }).catchError((error) {
      emit(HomeErrorUpdateUserState(error.toString()));
    });
  }
}
