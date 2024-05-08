import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartData extends ChangeNotifier {

  List<dynamic> _cartItems = [];
  List<dynamic> get cartItems => _cartItems;

  void addItemToCart(dynamic item) {
    if(isInCart(item) == true){
      return;
    }
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(dynamic item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  bool isInCart(dynamic item) {
    for (var i in _cartItems) {
      if ( i == item) {
        return true;
      }
    }
    return false;
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      totalPrice += item.getGia() * item.getQuantity();
    }
    return totalPrice;
  }

}
