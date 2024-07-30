import 'package:ecommerce_mobile_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_mobile_app/Provider/favorite_provider.dart';
import 'package:ecommerce_mobile_app/screens/Home/home_screen.dart';
import 'package:ecommerce_mobile_app/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // for add to cart
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          // for favorite
          ChangeNotifierProvider(
            create: (_) => FavoriteProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: HomeScreen(),
        ),
      );
}