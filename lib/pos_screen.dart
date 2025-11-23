import 'package:flutter/material.dart';
import 'package:flutter_win_auth/models.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  // Dummy data - replace with API call
  final List<Product> _products = [
    Product(id: 1, name: 'Coca-Cola', price: 1.50, categoryId: 1),
    Product(id: 2, name: 'Pepsi', price: 1.50, categoryId: 1),
    Product(id: 3, name: 'Fanta', price: 1.50, categoryId: 1),
    Product(id: 4, name: 'Sprite', price: 1.50, categoryId: 1),
    Product(id: 5, name: 'Water', price: 1.00, categoryId: 1),
    Product(id: 6, name: 'Chips', price: 2.00, categoryId: 2),
    Product(id: 7, name: 'Chocolate', price: 2.50, categoryId: 2),
    Product(id: 8, name: 'Candy', price: 1.00, categoryId: 2),
  ];

  final List<CartItem> _cart = [];

  void _addToCart(Product product) {
    setState(() {
      for (var item in _cart) {
        if (item.product.id == product.id) {
          item.quantity++;
          return;
        }
      }
      _cart.add(CartItem(product: product));
    });
  }

  double get _cartTotal {
    return _cart.fold(0, (total, current) => total + current.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point of Sale'),
      ),
      body: Row(
        children: [
          // Products Section
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => _addToCart(product),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name),
                        Text('\$${product.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Cart Section
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  'Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      final item = _cart[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Qty: ${item.quantity}'),
                        trailing: Text('\$${item.total.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Text(
                  'Total: \$${_cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
