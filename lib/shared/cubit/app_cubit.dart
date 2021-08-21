import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/shared/cubit/app_states.dart';
import 'package:souq/shared/network/local/cache_hlper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? cache}) {
    if (cache != null) {
      // there's cache --> take the value and no need for caching
      isDark = cache;
      emit(AppChangemode());
    } else {
      // there's no cache --> cache the light mode (used on pressing the toggle button)
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangemode());
      });
    }
  }
}
