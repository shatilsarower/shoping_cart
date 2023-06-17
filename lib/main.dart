import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product List',
      theme: ThemeData.dark(),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 15),
    Product(name: 'Product 4', price: 20),
    Product(name: 'Product 5', price: 22),
    Product(name: 'Product 6', price: 34),
    Product(name: 'Product 7', price: 203),
    Product(name: 'Product 8', price: 2012),
    Product(name: 'Product 9', price: 3000),
  ];

  int cartTotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (products[index].counter > 0) {
                        products[index].counter--;
                        updateCartTotal();
                      }
                    });
                  },
                ),
                Text(products[index].counter.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      products[index].counter++;
                      updateCartTotal();
                      if (products[index].counter == 5) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Congratulations!'),
                              content: Text(
                                  'You\'ve bought 5 ${products[index].name}!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartPage(cartTotal: cartTotal)),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void updateCartTotal() {
    cartTotal = products.fold(0, (sum, product) => sum + product.counter);
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});
}

class CartPage extends StatelessWidget {
  final int cartTotal;

  const CartPage({super.key, required this.cartTotal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Center(
        child: Text('Total: $cartTotal'),
      ),
    );
  }
}
