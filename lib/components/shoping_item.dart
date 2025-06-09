import 'package:clothly/components/show_image.dart';
import 'package:flutter/material.dart';

class ShopingItem extends StatefulWidget {
  final String name;
  final int id;
  final String item;
  final String description;
  final String imageLink;
  final List<String> size;

  const ShopingItem(
      {super.key,
      required this.name,
      required this.id,
      required this.item,
      required this.description,
      required this.imageLink,
      required this.size});

  @override
  State<ShopingItem> createState() => _ShopingItemState();
}

class _ShopingItemState extends State<ShopingItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(widget.description),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: ShowImage(imageLink: widget.imageLink)),
          ],
        ),
      ),
    );
  }
}
