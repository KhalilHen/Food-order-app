import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderStatusPending extends StatefulWidget {
  const OrderStatusPending({super.key});

  @override
  State<OrderStatusPending> createState() => _OrderStatusPendingState();
}

class _OrderStatusPendingState extends State<OrderStatusPending>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,

              "Your order is succesfully created!!",
              style: TextStyle(fontSize: 24, color: Colors.grey[650]),
            ),
            const SizedBox(height: 80),
            RotationTransition(
              turns: _controller,

              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 40,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    "The Restaurant will confirm your order shortly",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
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
