// @pragma('vm:entry-point')
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hf_customer_app/firebase_options.dart';
// import 'notification_helpers.dart';
// Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     final plugin = FlutterLocalNotificationsPlugin();
//     await plugin.initialize(
//       settings:  const InitializationSettings(
//       // const InitializationSettings(
//         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       ),
//     );
//     await NotificationHelpers.showNotification(message, plugin);
//   } catch (e) {
//     debugPrint('Background error: $e');
//   }
// }