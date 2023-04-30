import 'package:chauffeur/forms/seller_form.dart';
import 'package:chauffeur/providers/product_provider.dart';

import 'package:chauffeur/screens/home_screen.dart';
import 'package:chauffeur/screens/login_screen.dart';
import 'package:chauffeur/screens/main_screen.dart';
import 'package:chauffeur/screens/product_details_screen.dart';
import 'package:chauffeur/screens/splash_screen.dart';
import 'package:chauffeur/screens/success_screen.dart';
import 'package:chauffeur/providers/category_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chauffeur/seller/seller_category_list.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => CategoryProvider(),
        ),
        ListenableProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        MainScreen.id: (context) => const MainScreen(),
        SellerCategoryListScreen.id: (context) =>
            const SellerCategoryListScreen(),
        SellerForm.id: (context) => const SellerForm(),
        SuccessScreen.id: (context) => const SuccessScreen(),
        ProductDetailsScreen.id: (context) => const ProductDetailsScreen(),
      },
    );
  }
}
