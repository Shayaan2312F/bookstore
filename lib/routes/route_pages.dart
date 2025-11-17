import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/screens/about_page.dart';
import 'package:flutter_project_2208e/screens/cart_page.dart';
import 'package:flutter_project_2208e/screens/home_page.dart';
import 'package:flutter_project_2208e/screens/manage_user_page.dart';
import 'package:flutter_project_2208e/screens/order_page.dart';
import 'package:flutter_project_2208e/screens/product_view_page.dart';
import 'package:flutter_project_2208e/screens/approved_orders.dart';


class PageRoutes{
  static const String home = HomePage.routeName;
  static const String about = AboutUsPage.routeName;
  static const String muser = ManageUserPage.routeName;
  static const String prodview = ProductViewPage.routeName;
  static const String cart = CartPage.routeName;
  static const String order = OrderPage.routeName;
  static const String approvedorder = ApprovedOrderPage.routeName;  // This should now work correctly
}







