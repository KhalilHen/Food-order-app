import 'package:flutter/material.dart';
import 'package:hf_customer_app/core/utils/utils.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              CircleAvatar(
                radius: 140,
                backgroundColor: Colors.grey.shade300,

                // backgroundColor: Colors.red,
                child: Icon(
                  Icons.error_outline,
                  size: 175,
                  color: Colors.grey.shade800,
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                "Page not found",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),

                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "The page or resource you are looking for doesn\t exist, has been removed  or is temporarily unavailable.",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFFFF7A45),
                    foregroundColor: Colors.white,

                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () => context.go('/restaurants'),
                    icon: const Icon(
                      Icons.restaurant_outlined,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                    label: const Text(
                      "Browse restaurants",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],

            //  ! Werkt nog niet moet naar gekeken worden.
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Padding(
          //         padding: const EdgeInsets.all(24),
          //         child: FloatingActionButton.extended(
          //           backgroundColor: Colors.white,
          //           foregroundColor: const Color(0x45FFFF7A),

          //           elevation: 6,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30),
          //           ),

          //           onPressed: () => context.pop(),
          //           icon: const Icon(
          //             Icons.arrow_back,
          //             color: Colors.black87,
          //             fontWeight: FontWeight.normal,
          //           ),
          //           label: const Text(
          //             "Go back",
          //             style: TextStyle(
          //               color: Colors.black87,
          //               fontWeight: FontWeight.w500,
          //               fontSize: 16,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
