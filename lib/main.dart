import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pabulum_teacher/routes/app_routes.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        navigatorKey: navigatorKey,
        title: 'Pabulum Teacher',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: RouteName.splashScreen,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
