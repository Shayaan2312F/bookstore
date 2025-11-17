import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/firebase_options.dart';
import 'package:flutter_project_2208e/routes/route_pages.dart';
import 'package:flutter_project_2208e/screens/about_page.dart';
import 'package:flutter_project_2208e/screens/approved_orders.dart';
import 'package:flutter_project_2208e/screens/cart_page.dart';
import 'package:flutter_project_2208e/screens/home_page.dart';
import 'package:flutter_project_2208e/screens/manage_user_page.dart';
import 'package:flutter_project_2208e/screens/order_page.dart';
import 'package:flutter_project_2208e/screens/product_view_page.dart';

import 'pages/splash_page.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const FlutterFire());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform.copyWith(
      // 👇 PASTE YOUR DATABASE URL HERE
      databaseURL: "https://boook-store-f5faa-default-rtdb.firebaseio.com/",
    ),
  );

  runApp(FlutterFire());
}


class FlutterFire extends StatelessWidget {
  const FlutterFire({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      title: 'Book Store App',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.pink[800],
          appBarTheme: const AppBarTheme(
              //color: Colors.black,
              backgroundColor: Colors.pinkAccent),
          textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.yellow),
          titleLarge: TextStyle(
            color: Colors.white, // Specify the color you want for titleLarge
            fontSize: 20, // Set the font size
            fontWeight: FontWeight.bold, // Set the font weight
          ),
        ),
              
              
              
              ),
      routes: {
        PageRoutes.home: (context) => const HomePage(),
        PageRoutes.about: (context) => const AboutUsPage(),
        PageRoutes.muser: (context)=> const ManageUserPage(),
        PageRoutes.prodview: (context)=> const ProductViewPage(),
        PageRoutes.cart:(context)=> const  CartPage(),
        PageRoutes.order:(context)=>const OrderPage(),
        // PageRoutes.approvedorder: (context) => const ApprovedOrderPage()     

      },
    );
  }
}
