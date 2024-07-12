import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore.dart';
import 'package:flutter/material.dart';
import 'product.dart';


class Shop extends ChangeNotifier {
  final List <Product> _shop = [];

  final List <Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  Shop() {
    _startProductStream();
  }

  void _startProductStream(){
    FirestoreService().getProductsStream().listen((QuerySnapshot snapshot) {
      _shop.clear();
      for(var data in snapshot.docs){
        _shop.add(Product(
          name: data['name'], 
          price: data['price'], 
          description: data['description'], 
          imagePath: data['imagepagh']
        ));
      }
      notifyListeners();
    });
  }

  //aumentar quant prod no carrinho
  void incrementoQuantity(Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).incrementoQuantity();
    notifyListeners();
  }

  //diminui a quant de prod no cart
  void decreamentQuantity(Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).decreamentQuantity();
    notifyListeners();
  } 

  //reseta/remove a quant prod
  void initialQuantity (Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).initialQuantity();
    notifyListeners();
  }

  void addToCart(Product item) {
    if (_cart.contains(item)) {
      incrementoQuantity(item);
      notifyListeners();
    } else {
      _cart.add(item);
      incrementoQuantity(item);
      notifyListeners();
    }
  }

  void removeFromCart(Product item) {
    initialQuantity(item);
    _cart.remove(item); 
    notifyListeners();
  }

  //diminuir
  void decrementFromCart(Product item) {
    decreamentQuantity(item);
    notifyListeners();
  }
}