import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/theme/cubit/theme_state.dart';


enum ThemeModeState { light, dark, system }

class ThemeCubit extends Cubit<ThemeState> {
 ThemeCubit() : super(const ThemeInitial()) {
  loadSavedTheme();
}

  static ThemeCubit get(BuildContext context) =>
      BlocProvider.of<ThemeCubit>(context);

  void setTheme(ThemeMode themeMode) async {
    await CacheHelper().saveData(
      key: "theme",
      value: themeMode.name, 
    );

    emit(ThemeChanged(themeMode));
  }

  void loadSavedTheme() {
    final savedTheme = CacheHelper().getData(key: "theme");

    if (savedTheme != null) {
      emit(ThemeChanged(_getThemeFromString(savedTheme)));
    }
  }

  ThemeMode _getThemeFromString(String theme) {
    switch (theme) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
