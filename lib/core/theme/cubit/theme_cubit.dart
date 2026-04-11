import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/theme/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with WidgetsBindingObserver {
  ThemeCubit() : super(const ThemeInitial()) {
    WidgetsBinding.instance.addObserver(this);
    loadSavedTheme();
  }

  static ThemeCubit get(BuildContext context) =>
      BlocProvider.of<ThemeCubit>(context);

  @override
  void didChangePlatformBrightness() {
    final savedTheme = CacheHelper().getData(key: "theme");

    if (savedTheme == "system" || savedTheme == null) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;

      final newMode = brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

      emit(ThemeChanged(newMode));
    }
  }

  void setTheme(ThemeMode themeMode) async {
    await CacheHelper().saveData(key: "theme", value: themeMode.name);
    emit(ThemeChanged(themeMode));
  }

  void loadSavedTheme() {
    final savedTheme = CacheHelper().getData(key: "theme");

    if (savedTheme != null) {
      emit(ThemeChanged(_getThemeFromString(savedTheme)));
    } else {
      // ← مهم جدًا
      emit(const ThemeChanged(ThemeMode.system));
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

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
