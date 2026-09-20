/// Represents a market product.
class Product {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final rawPrice = json['price'];

    return Product(
      id: rawId is num ? rawId.toString() : rawId?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'accessories',
      price: rawPrice is num ? rawPrice.toDouble() : double.tryParse(rawPrice?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
    };
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get total => product.price * quantity;
}
