import 'dart:convert';
import 'package:clothly/components/shoping_item.dart';
import 'package:clothly/data/data.dart';
import 'package:clothly/data/filter_provider.dart';
import 'package:clothly/pages/drawer_page.dart';
import 'package:clothly/pages/item_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _PageOneState();
}

class _PageOneState extends State<HomePage> {
  String itemName = "All";

  void filterData(String item) {
    Provider.of<FilterProvider>(context, listen: false).addItems(item: item);
  }

  void search(String value) {
    Provider.of<FilterProvider>(context, listen: false).search(value);
  }

  @override
  void initState() {
    super.initState();
    itemName = "All";
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/items'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Product> products =
            data.map((item) => Product.fromMap(item)).toList();

        // Clear existing data and add new
        Data.arr.clear();
        for (var product in products) {
          Data.addItem(product);
        }

        // Notify provider to reload from Data.arr
        if (mounted) {
          Provider.of<FilterProvider>(context, listen: false)
              .addItems(item: itemName);
        }
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Clothly",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 206, 60, 7)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
              onChanged: (value) {
                search(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search ...",
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(30))),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(30)),
                ),
              ),
            ))
          ],
        ),
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Data.itemNames.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        itemName = Data.itemNames[index];
                        filterData(itemName);
                      });
                    },
                    child: Chip(
                        backgroundColor: (itemName == Data.itemNames[index])
                            ? Colors.black
                            : Colors.white,
                        label: Text(
                          Data.itemNames[index],
                          style: TextStyle(
                              color: (itemName == Data.itemNames[index])
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<FilterProvider>(
              builder: (context, filterProvider, child) {
                final filteredList = filterProvider.filterArr;

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ItemPage(
                              name: item["name"],
                              id: item["id"],
                              item: item["item"],
                              description: item["description"],
                              imageLink: item["imageLink"],
                              size: item["size"],
                              price: item["price"],
                            );
                          },
                        ));
                      },
                      child: ShopingItem(
                        name: item["name"],
                        id: item["id"],
                        item: item["item"],
                        description: item["description"],
                        imageLink: item["imageLink"],
                        size: item["size"],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
