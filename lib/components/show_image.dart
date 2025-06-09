import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  final String imageLink;
  const ShowImage({
    super.key,
    required this.imageLink,
  });

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image(image: NetworkImage(widget.imageLink))),
    );
  }
}
