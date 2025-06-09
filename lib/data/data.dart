class Data {
  static List<Map<String, dynamic>> arr = [];

  static List<String> itemNames = [
    "All",
    "Hoodie",
    "T-shirt",
    "Jeans",
    "Crop Tops",
    "Frock",
  ];

  static void addItem(Product item) {
    arr.add(item.toMap());
  }

  static void removeItemById(String id) {
    arr = arr.where((item) => item['id'] != id).toList();
  }
}

class Product {
  final int id;
  final String item;
  final String name;
  final String description;
  final String imageLink;
  final List<String> size;
  String chooseSize;
  final double price;

  Product({
    required this.id,
    required this.item,
    required this.name,
    required this.description,
    required this.imageLink,
    required this.size,
    this.chooseSize = '',
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      item: map['item'],
      name: map['name'],
      description: map['description'],
      imageLink: map['imageLink'],
      size: List<String>.from(map['size']),
      chooseSize: map['chooseSize'],
      price: map['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item,
      'name': name,
      'description': description,
      'imageLink': imageLink,
      'size': size,
      'chooseSize': chooseSize,
      'price': price,
    };
  }
}
