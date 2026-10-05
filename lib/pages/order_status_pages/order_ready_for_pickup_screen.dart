import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderStatusReady extends StatelessWidget {
  // final Restaurant restaurant;
  const OrderStatusReady({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.orange,

        title: Text(
          'Order #1',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ready icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[50],
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 50,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Order Ready text
            Text(
              "Order Ready!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),

            // Pickup message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Your order is ready for pickup at the restaurant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Pickup details card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    //! For now still static info
                    //TODO Update this into the restaurant data
                    _buildInfoRow(
                      Icons.store,
                      "Pickup Location",
                      "Restaurant Name",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.location_on,
                      "Address",
                      "123 Main Street",
                    ),
     
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              FilledButton(
                onPressed: () {
                  // Show directions or map
                  context.go('/directions');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Get Directions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // OutlinedButton(
              //   onPressed: () {
              //     context.go('/order-details');
              //   },
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.deepOrange,
              //     side: const BorderSide(color: Colors.deepOrange, width: 2),
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              //   child: const Text(
              //     "View Order Details",
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //       letterSpacing: 0.3,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepOrange[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}