import 'package:flutter/material.dart';
import 'food_item.dart';

class Cart extends StatefulWidget {
  final List<FoodItem> cartItems;

  const Cart({super.key, required this.cartItems});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = List.generate(widget.cartItems.length, (_) => 1);
  }

  void _removeItem(int index) {
    setState(() {
      quantities.removeAt(index);
      widget.cartItems.removeAt(index);
    });
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      subtotal += widget.cartItems[i].price * quantities[i];
    }
    return subtotal;
  }

  double _calculateTax() => _calculateSubtotal() * 0.10;
  double _calculateTotal() => _calculateSubtotal() + _calculateTax();

  void _showCheckoutDialog(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Order Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Items: ${widget.cartItems.length}'),
            Text('Subtotal: Rs ${_calculateSubtotal().toStringAsFixed(0)}'),
            Text('Tax (10%): Rs ${_calculateTax().toStringAsFixed(0)}'),
            const SizedBox(height: 8),
            Text(
              'Total: Rs ${_calculateTotal().toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showOrderConfirmation(context);
            },
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: colors.primary),
            const SizedBox(width: 8),
            const Text('Order Confirmed!'),
          ],
        ),
        content: const Text('Your order has been placed successfully.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.cartItems.clear();
                quantities.clear();
              });
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),

      body: widget.cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty 😕',
          style: theme.textTheme.titleMedium,
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                final quantity = quantities[index];

                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, bottom: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(60, 16, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.des,
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs ${(item.price * quantity).toStringAsFixed(0)}',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  QuantityController(
                                    quantity: quantity,
                                    onIncrement: () =>
                                        setState(() => quantities[index]++),
                                    onDecrement: () {
                                      setState(() {
                                        quantity > 1
                                            ? quantities[index]--
                                            : _removeItem(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 30,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(item.image),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: colors.outline)),
            ),
            child: Column(
              children: [
                _row('Subtotal', _calculateSubtotal()),
                _row('Tax (10%)', _calculateTax()),
                _row('Total', _calculateTotal(), bold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCheckoutDialog(context),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            'Rs ${value.toStringAsFixed(0)}',
            style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class QuantityController extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityController({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          '$quantity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: onDecrement,
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
