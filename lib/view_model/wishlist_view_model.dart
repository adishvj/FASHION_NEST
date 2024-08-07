import 'package:flutter/material.dart';

import '../models/product_model2.dart';
import '../models/wishlist_model.dart';
import '../services/wishlist_service.dart';

class WishViewModel extends ChangeNotifier {
  bool loading = false;
  List<WishModel> wishItems = [];
  List<ProductModel> wishData = [];

  final _wishService = WishService();

  Future<void> fetchWishContents(String userid, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      // Fetch cart contents
      wishItems = await _wishService.getWishContents(userid);

      // Clear previous cartData
      wishData.clear();

      // Populate cartData with the latest items
      for (var wishItem in wishItems) {
        wishData.add(wishItem.productId!);
      }
      print("hiiiiiiiiiiiiiiii${wishData.length}");

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch cart contents: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWishItem(String itemId, BuildContext context) async {
    try {
      print("gggggggggggggggggggggggggggggggggg${itemId}");
      loading = true;
      notifyListeners();

      bool isSuccess = await _wishService.deleteItem(itemId);

      if (isSuccess) {
        // Remove the item from the local list
        wishItems.removeWhere((item) => item.sId == itemId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item deleted successfully.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete item.')),
        );
      }
    } catch (e) {
      print('Delete error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addProductToWish({
    required String userid,
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _wishService.addProductToWish(userid: userid, product: product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product added to wishlist successfully"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product to wishlist: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
