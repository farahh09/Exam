import 'package:exam/core/api_manager.dart';
import 'package:exam/core/home_repo.dart';
import 'package:exam/provider/home_provider.dart';
import 'package:exam/screens/cart_screen.dart';
import 'package:exam/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeProvider(homeRepo: HomeRepo(ApiManager())),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (c) => HomeScreen(),
        CartScreen.routeName : (c) => CartScreen(),
      },
    );
  }
}

