import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothly/data/data.dart';
import 'package:flutter/foundation.dart'; // Assuming Product and Data.addItem() are defined here

class Database {
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('items');
  Map<String, dynamic> data2 = {};
  Future<void> fetchData() async {
    try {
      QuerySnapshot snapshot = await firestore.get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data2 = data;
        Product product = Product.fromMap(data);
        Data.addItem(product);
      }

      if (kDebugMode) {
        print('Data fetched and added to local list.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('number : $data2 Error fetching data: $e');
      }
    }
  }
}
