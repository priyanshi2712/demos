import 'package:flutter/material.dart';
import '../../src/view/home_screen/home_screen.dart';
import '../../src/view/response/dashboard_screen.dart';

class RoutesUtils {
  static const String initialRoute = '/';
  static const String dashboard = '/Dashboard';
  static const String logInScreen = '/LogInScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const Dashboard();
        });

      default:
        return MaterialPageRoute(builder: (context) {
          return const Dashboard();
        });
    }
  }
}
