import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hf_customer_app/controller/location_service_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //TODO Make a unit/E2E test with retrieving location and displaying nearby restaurants
  String? _currentAddress;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  //TODO Use  this flow later where location is needed
                  // TODO So #1 Ask whether the app has permission #2 Handle it if it hasn't the correct permission
                  //TODO #3  If app has acces to the location then retrieve it.

                  final hasPermission =
                      await LocationHandler.handleLocationPermission();

                  if (hasPermission == LocationPermissionStatus.deniedForever) {
                    if (!context.mounted) return;

                    showDialog(
                      context: context,
                      builder: (context) => askForLocationDialog(),
                    );
                  } else if (hasPermission ==
                      LocationPermissionStatus.granted) {
                    _currentPosition =
                        await LocationHandler.getCurrentPosition();
                    _currentAddress =
                        await LocationHandler.getAddressFromLatLng(
                          _currentPosition!,
                        );
                  }

                  setState(() {});
                },
                child: const Text("Get Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO Refactor this function name
  askForLocationDialog() {
    return AlertDialog(
      title: const Text("We need your location"),
      content: const Padding(
        padding: EdgeInsets.all(16),

        child: Text(
          "We need your location to retrieve restaurants nearby you else we can't retrieve any restaurants nearby. Please enable your location by clicking on the button",
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () =>
                  // LocationHandler.openAppSettings(),
                  context.pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                LocationHandler.openAppSettings();
                // ! Depending on how it's gonna be used close the dialog after sending the user to the device settings
                context.pop();
              },

              child: const Text("Open settings app"),
            ),
          ],
        ),
      ],
    );
  }
}
