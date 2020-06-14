import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dammy_users.dart';
import 'package:flutter_crud/models/user.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void put(User user) {
    if (user == null) return;

    print(user.id);
    print(user.name);
    print(user.email);

    // alterar
    if (user.id != null && user.id.isNotEmpty && _items.containsKey(user.id)) {
      alterar(user);
    } else {
      // adicionar
      adicionar(user);
    }
    notifyListeners();
  }

  void adicionar(User user) {
    final String id = Random().nextDouble().toString();
    _items.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            email: user.email,
            avatarUrl: user.avatarUrl));
  }

  void alterar(User user) {
    _items.update(user.id, (value) => user);
  }

  void remove(User user) {
    if (user.id != null && user.id.isNotEmpty) {
      _items.remove(user.id);
    }
    notifyListeners();
  }
}
