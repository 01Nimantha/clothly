import 'package:clothly/components/shoping_item.dart';
import 'package:clothly/data/data.dart';
import 'package:clothly/data/database.dart';
import 'package:clothly/data/filter_provider.dart';
import 'package:clothly/pages/drawer_page.dart';
import 'package:clothly/pages/item_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final Database database = Database();

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    await database.fetchData();
    if (!mounted) return;
    Provider.of<FilterProvider>(context, listen: false).addItems(item: "All");
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
