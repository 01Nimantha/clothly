import 'package:clothly/data/data.dart';
import 'package:flutter/foundation.dart';

class FilterProvider extends ChangeNotifier {
  List<Map<String, dynamic>> filterArr = Data.arr.toList();

  void addItems({required String item}) {
    filterArr.clear();
    if (item == "All") {
      filterArr = Data.arr.toList();
    } else {
      filterArr = Data.arr.where((data) => data['item'] == item).toList();
    }
    notifyListeners();
  }

  void search(String text) {
    filterArr.clear();
    if (text.isEmpty) {
      filterArr = Data.arr.toList();
    } else {
      filterArr = Data.arr
          .where((product) => product['name']
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
