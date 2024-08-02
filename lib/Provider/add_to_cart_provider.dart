import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model2.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cart = [];
  List<ProductModel> get cart => _cart;
  void toogleFavorite(ProductModel product) {
    // toogleFavorite is just a name you can give what ever you wants to

    if (_cart.contains(product)) {
      for (ProductModel element in _cart) {
        element.quandity++;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

// for increment
  incrementQtn(int index) {
    _cart[index].quandity++;
    notifyListeners();
  }

  // for decrement
  decrementQtn(int index) {
    if (_cart[index].quandity <= 1) {
      return;
    }
    _cart[index].quandity--;
    notifyListeners();
  }

  // for total amount
  totalPrice() {
    double myTotal = 0.0; // initial
    for (ProductModel element in _cart) {
      myTotal += element.price * element.quandity;
    }
    return myTotal;
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}
