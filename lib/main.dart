import 'package:flutter/material.dart';
import 'package:flutter_intership_task_app/features/authentication/login/login_screen.dart';
import 'package:flutter_intership_task_app/features/authentication/otp/otp_screen.dart';
import 'package:flutter_intership_task_app/features/authentication/sign%20up/signup_screen.dart';
import 'package:flutter_intership_task_app/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check login status before running the app
  final isLoggedIn = await checkUserLoginStatus();

  runApp(MyApp(initialLoginStatus: isLoggedIn));
}

Future<bool> checkUserLoginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatefulWidget {
  final bool initialLoginStatus;

  const MyApp({required this.initialLoginStatus, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _createRouter(widget.initialLoginStatus);
  }

  GoRouter _createRouter(bool isLoggedIn) {
    return GoRouter(
      initialLocation: isLoggedIn ? '/' : '/login',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: '/otp',
          builder: (context, state) => const OtpScreen(),
        ),
      ],
      redirect: (context, state) async {
        final allowedUnauthenticatedRoutes = ['/login', '/signup', '/otp'];

        // Check login status at runtime
        final prefs = await SharedPreferences.getInstance();
        final currentLoginStatus = prefs.getBool('isLoggedIn') ?? false;

        if (!currentLoginStatus &&
            !allowedUnauthenticatedRoutes.contains(state.matchedLocation)) {
          return '/login';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
