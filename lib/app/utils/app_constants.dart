import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/cart/views/cart_view.dart';
import 'package:foodie/app/modules/favourite/views/favourite_view.dart';
import 'package:foodie/app/modules/home/views/home_view.dart';
import 'package:foodie/app/modules/profile/views/profile_view.dart';

class Constants {
  Constants._();

  static const tabItemList = [
    TabItem(icon: Icons.home),
    TabItem(icon: Icons.favorite),
    TabItem(icon: Icons.shopping_cart),
    TabItem(icon: Icons.person),
  ];

  static final screens = [
    HomeView(),
    FavouriteView(),
    CartView(),
    ProfileView(),
  ];
  static const screensHeader = [
    'Home',
    'Favourites',
    'Cart',
    'Profile',
  ];

  //style constants
  static const BoxShadow boxShadow = BoxShadow(
    color: Color(0xFFB4B4B4),
    offset: Offset(0, 2),
    blurRadius: 5,
    spreadRadius: 0,
  );

  //style constants
  static const BoxShadow lightBoxShadow = BoxShadow(
    color: Color(0xFFF2F2F2),
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 3,
  );
}
