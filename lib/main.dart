import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/theme/app_theme.dart';
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
import 'package:save_plant/core/theme/cubit/theme_state.dart';
import 'package:save_plant/feature/auth/data/repo/user_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper().init();

  await dotenv.load(fileName: ".env");

  Gemini.init(apiKey: dotenv.env['CHAT_BOT_API_KEY']!);

  runApp(const Mahsoly());
}

class Mahsoly extends StatelessWidget {
  const Mahsoly({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
          create: (context) =>
              UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.themeMode,
                home: LoginView(),
              );
            },
          );
        },
      ),
    );
  }
}
