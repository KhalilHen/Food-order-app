import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'destinations.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
  bottomNavigationBar: NavigationBar(
  selectedIndex: navigationShell.currentIndex,
  onDestinationSelected: navigationShell.goBranch,
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
  indicatorColor: Colors.orange.shade100,
  destinations: destinations
      .map(
        (destination) => NavigationDestination(
          icon: Icon(destination.icon, color: Colors.grey.shade600),
          selectedIcon: Icon(destination.icon, color: Colors.deepOrange),
          label: destination.label,
        ),
      )
      .toList(),
),
    );
  }
}
