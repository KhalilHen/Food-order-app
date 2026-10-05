import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hf_customer_app/models/enum/navigation_type_enum.dart';

class UIHelper {
static void showError(BuildContext context, String message) {
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message))
  );
}


  // * Use this function when ever your navigating a user to another page inside a async call
  // * To prevent memory leaks, or unwanted state changes, etc.
  static void navigateTo(
    BuildContext context,
    String route,
    NavigationType routeType,
    Object? extra,
  ) {
    if (!context.mounted) return;  
    // !!!  if(!context.mounted || !mounted ) return;

    switch (routeType) {
      case NavigationType.go:
        context.go(route, extra:  extra);
      case NavigationType.push:
        context.push(route);

     
    }
  }
}
