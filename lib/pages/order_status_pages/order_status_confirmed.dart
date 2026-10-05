import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderStatusConfirmed extends StatelessWidget {
  const OrderStatusConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          // !! For now an static order id
          //TODO Adjust this in the future ^^
          'Order #1',
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange[50],
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 3,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.restaurant_menu,
                  size: 45,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Order Accepted text
            Text(
              "Order Accepted!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),

            // Preparation message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "The restaurant is now preparing your delicious meal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Estimated time card
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.deepOrange,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Estimated Pickup Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "15-20 minutes",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "We'll notify you when it's ready",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
          child: FilledButton(
            onPressed: () {

              context.go('/restaurants');
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

            //TODO Perhaps change this into  "view order details"
            child: const Text(
              "View other restaurants",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}