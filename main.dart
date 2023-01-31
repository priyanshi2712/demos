import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:knovator/src/view/home_screen/home_screen.dart';
import 'package:knovator/src/view/response/dashboard_screen.dart';
import 'package:knovator/utilities/database/local_database.dart';
import 'package:knovator/utilities/routes/provider_bindings.dart';
import 'package:knovator/utilities/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DatabaseHelep().initDatabase();

  // await SharedPreferencesUtils().initSharedPreference();
  runApp(
    MultiProvider(
      providers: ProviderBindings.providers,
      child: const MaterialApp(
        onGenerateRoute: RoutesUtils.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesUtils.initialRoute,
        home: Dashboard(),
      ),
    ),
  );
}
