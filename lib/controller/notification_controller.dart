// !! Currently not used for V1.0
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// import '../core/notifications/notification_service.dart';

// class NotificationController {




//   Future<void> setUp() async {
//       await NotificationService().requestPermission();
//     NotificationService().onTap.listen((data) {
//       debugPrint('Notification tapped: $data');
      
//       if (data['type'] == 'order') {
//         // Navigator.pushNamed(context, '/orders');
//         print('Navigatie orders ');
//       }
//     });
//   }
//   Future<void> printDeviceToken()  async {

//       final token = await NotificationService.getToken();
//         print('═══════════════════════════════════');
//   print('FCM TOKEN:');
//   print(token);
//   print('═══════════════════════════════════');

//   }

// // Future<void> onUserLogin(String userId) async {
// //   final token = await NotificationService.getToken();
  
// //   if (token != null) {
// //     await http.post(
// //       Uri.parse('https://your-api.com/register-device'),
// //       headers: {'Content-Type': 'application/json'},
// //       body: jsonEncode({
// //         'user_id': userId,
// //         'fcm_token': token,
// //         'platform': Platform.isIOS ? 'ios' : 'android',
// //       }),
// //     );
// //   }
// // }

// // @pragma('vm:entry-point')
// // Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   await showNotification(message);
// // }

// }