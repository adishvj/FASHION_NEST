import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cart_model.dart';
import '../models/product_model2.dart';

class CartService {
  // Add product to cart
  Future<void> addProductToCart(
      {required String userid, required ProductModel product}) async {
    final Uri url = Uri.parse('$baseurl/api/wish/addItemWishlist');
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${product.sId}");

    final Map<String, dynamic> cartData = {
      'userId': userid,
      'productId': product.sId,
    };

    try {
      final response = await http.post(url, body: cartData);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        print('Product added to wishlist successfully');
      } else {
        print('3');
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      print(e);
      throw Exception('An error occurred: $e');
    }
  }

  // Fetch cart contents for a user
  Future<List<CartModel>> getCartContents(String userid) async {
    final Uri url = Uri.parse('$baseurl/api/wish/viewWishlist/$userid');

    try {
      final response = await http.get(url);
      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
      print("ccccccccccccccc${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var cartList = (data['data'] as List)
              .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Cart list: $cartList');

          return cartList;
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load cart contents');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // // Remove product from cart
  // Future<void> removeProductFromCart({
  //   required String userid,
  //   required String productId,
  // }) async {
  //   final Uri url =
  //       Uri.parse('$baseurl/api/cart/removeFromCart/$userid/$productId');
  //   final Map<String, dynamic> cartData = {
  //     'userid': userid,
  //     'productid': productId,
  //   };
  //
  //   print(userid);
  //   print(productId);
  //
  //   try {
  //     final response = await http.delete(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(cartData),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Product removed from cart successfully');
  //     } else {
  //       throw Exception('Failed to remove product from cart-');
  //     }
  //   } catch (e) {
  //     throw Exception('An error occurred: $e');
  //   }
  // }

  //
  Future<bool> deleteItem(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseurl/api/cart/removeItemWishlist/$itemId'),
    );

    return response.statusCode == 200;
  }
}
