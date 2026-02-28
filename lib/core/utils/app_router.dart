import 'package:go_router/go_router.dart';
import 'package:save_plant/feature/auth/presentation/views/signin_view.dart';
import 'package:save_plant/feature/auth/presentation/views/signup_view.dart';
import 'package:save_plant/feature/onboarding/onboarding_view.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => OnboardingView(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => SigninView(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupView(),
    ),
  ],
);
  