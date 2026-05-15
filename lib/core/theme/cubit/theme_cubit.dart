import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/theme/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with WidgetsBindingObserver {
  ThemeCubit() : super(ThemeInitial(ThemeMode.system)) {
    WidgetsBinding.instance.addObserver(this);
  }

  static ThemeCubit get(BuildContext context) =>
      BlocProvider.of<ThemeCubit>(context);

  String email = "";

  void reset() {
    email = "";
    emit(const ThemeChanged(ThemeMode.system));
  }

  void setUser(String userEmail) {
    debugPrint("🔄 Switching Theme to User: $userEmail");
    email = userEmail;
    loadSavedThemeForUser(userEmail);
  }

  void updateUserEmail(String newEmail) async {
    if (email.isEmpty || email == newEmail) return;
    final savedTheme = CacheHelper().getData(key: 'theme_$email');
    email = newEmail;
    if (savedTheme != null) {
      await CacheHelper().saveData(key: 'theme_$newEmail', value: savedTheme);
    }
  }

  void loadSavedThemeForUser(String userEmail) {
    final savedTheme = CacheHelper().getData(key: 'theme_$userEmail');
    debugPrint("Loaded Theme for $userEmail: $savedTheme");
    if (savedTheme != null && savedTheme is String) {
      emit(ThemeChanged(_getThemeFromString(savedTheme)));
    } else {
      emit(const ThemeChanged(ThemeMode.system));
    }
  }

  void changeTheme(ThemeMode themeMode) async {
    debugPrint("Saving ${themeMode.name} for User: $email");
    await CacheHelper().saveData(key: 'theme_$email', value: themeMode.name);

    emit(ThemeChanged(themeMode));
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
  void didChangePlatformBrightness() {
    if (email.isEmpty) return;

    final savedTheme = CacheHelper().getData(key: 'theme_$email');

    if (savedTheme == null || savedTheme == "system") {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;

      emit(
        ThemeChanged(
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
