import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/models/search_model.dart';
import 'package:souq/shared/components/constants.dart';
import 'package:souq/shared/cubit/home_states.dart';
import 'package:souq/shared/cubit/search_states.dart';
import 'package:souq/shared/network/end_points.dart';
import 'package:souq/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchIntialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  // handle search API
  SearchModel? searchModel;
  Map<int, bool>? favourites = {};
  Map<int, bool>? carts = {};
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      //printFullText(value.data.toString());
      searchModel = SearchModel.fromJson(value.data);
      // fill favourites
      searchModel!.data!.data.forEach((element) {
        favourites!.addAll({
          element.id: element.inFavorites,
        });
      });
      // fill carts
      searchModel!.data!.data.forEach((element) {
        carts!.addAll({
          element.id: element.inCart,
        });
      });
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }

  // Handling Favourites without API
  void changeFavourites(int productID) {
    emit(SearchSuccessChangeFavouritesState());

    searchModel!.data!.data.forEach((element) {
      if (element.id == productID) element.inFavorites = !element.inFavorites;
    });

    searchModel!.data!.data.forEach((element) {
      favourites!.addAll({
        element.id: element.inFavorites,
      });
    });
    //print(favourites.toString());
  }

  // Handling Cart without API
  void changeCart(int productID) {
    emit(SearchSuccessChangeCartState());
    searchModel!.data!.data.forEach((element) {
      if (element.id == productID) element.inCart = !element.inCart;
    });

    searchModel!.data!.data.forEach((element) {
      carts!.addAll({
        element.id: element.inCart,
      });
    });
    //print(favourites.toString());
  }
}
