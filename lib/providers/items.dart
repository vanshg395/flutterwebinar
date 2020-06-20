import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items {
    return _items;
  }

  Future<void> addItem() async {}
  Future<void> getItems() async {}
}
