abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

class HomeChangeBottomNavigationBarState extends HomeStates {}

class HomeLoadingHomeDataState extends HomeStates {}

class HomeSuccessHomeDataState extends HomeStates {}

class HomeErrorHomeDataState extends HomeStates {
  final String error;
  HomeErrorHomeDataState(this.error);
}

class HomeLoadingCategoriesState extends HomeStates {}

class HomeSuccessCategoriesState extends HomeStates {}

class HomeErrorCategoriesState extends HomeStates {
  final String error;
  HomeErrorCategoriesState(this.error);
}

class HomeSuccessChangeFavouritesState extends HomeStates {}

class HomeErrorChangeFavouritesState extends HomeStates {
  final String error;
  HomeErrorChangeFavouritesState(this.error);
}

class HomeSuccessChangeCartState extends HomeStates {}

class HomeErrorChangCartState extends HomeStates {
  final String error;
  HomeErrorChangCartState(this.error);
}
