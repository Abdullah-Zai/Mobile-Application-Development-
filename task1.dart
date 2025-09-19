import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bidding Page',
      debugShowCheckedModeBanner: false,
      home: const MaximumBid(),
    );
  }
}

// This is the StatefulWidget
class MaximumBid extends StatefulWidget {
  const MaximumBid({super.key});

  @override
  State<MaximumBid> createState() => _MaximumBidState();
}

// This class manages the state
class _MaximumBidState extends State<MaximumBid> {
  int currentBid = 0;

  void increaseBid() {
    setState(() {
      currentBid += 50; // Add $50 each time
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidding Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Current Maximum Bid:',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${currentBid.toString()}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: increaseBid,
              child: const Text(
                'Increase Bid by \$50',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
