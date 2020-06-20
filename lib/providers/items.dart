import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items {
    return _items;
  }

  Future<void> deleteItem(String token, String id) async {
    final url = 'https://api-linking.herokuapp.com/delete/item/$id';
    try {
      final response = await http.delete(url, headers: {
        'Authorization': token,
      });
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getItems(String token) async {
    final url = 'https://api-linking.herokuapp.com/all/items';
    try {
      final response = await http.get(url, headers: {
        'Authorization': token,
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        _items = resBody['payload'];
      }
    } catch (e) {
      print(e);
    }
  }
}
