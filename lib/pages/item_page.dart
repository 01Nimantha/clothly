import 'package:clothly/data/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  final String name;
  final int id;
  final String item;
  final String description;
  final String imageLink;
  final List<String> size;
  final double price;

  const ItemPage({
    super.key,
    required this.name,
    required this.id,
    required this.item,
    required this.description,
    required this.imageLink,
    required this.size,
    required this.price,
  });

  @override
  State<ItemPage> createState() => _PageThreeState();
}

class _PageThreeState extends State<ItemPage> {
  String selectedSize = "";
  int size = -1;
  void addItem() {
    Provider.of<CartProvider>(context, listen: false).addtoCart({
      "name": widget.name,
      "imageLink": widget.imageLink,
      "selectedSize": selectedSize,
      "price": widget.price
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        // prevents overflow on smaller screens
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                widget.description,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Image.network(widget.imageLink),
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Price : US\$ ${widget.price.toString()} ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Available Sizes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 60, // fixed height for ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.size.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                size = index;
                                selectedSize = widget.size[index];
                              });
                            },
                            child: Chip(
                              backgroundColor:
                                  (size == index) ? Colors.black : Colors.white,
                              label: Text(
                                widget.size[index],
                                style: TextStyle(
                                  color: (size == index)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => {
                    if (selectedSize == "")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select a size! "),
                        ))
                      }
                    else
                      {
                        addItem(),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Your item add to the cart.")))
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 77, 231, 82),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
