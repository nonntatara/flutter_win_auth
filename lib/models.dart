class Product {
  final int id;
  final String name;
  final double price;
  final int categoryId;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productID'] ?? 0,
      name: json['productName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      categoryId: json['categoryID'] ?? 0,
      image: json['productImage'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryID'],
      name: json['categoryName'],
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get total => product.price * quantity;
}