import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/utils/utils.dart';
import 'package:hf_customer_app/core/routes/routes.dart';

Future<void> main({String? initialLocation}) async {
  WidgetsFlutterBinding.ensureInitialized();
//! Gebruik Firebase weer wanneer je verdergaat met het implementeren van pushnotificaties.
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
  //   await NotificationService().initialize();
  await Supabase.initialize(
    // TODO Fill here your supabase details in
    url: 'https://emshpkwskuaikbekxmqr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVtc2hwa3dza3VhaWtiZWt4bXFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5MzU0NTYsImV4cCI6MjA2NTUxMTQ1Nn0.mbnA0hHRutY_IsjluKZhe4lK7eD_z-OHkKW2GCwAseo',
  );
  Stripe.publishableKey = "pk_test_51RMqvUDGPSteiAEFrZSHat4MCX4bFVLWV9YogfzsTxm5VPvv7SVGv4JAWIbo2fTPhqjBOtCdkYhVmgVryrP6xani00eKRz21ap";
  //TODO Improve this later so it's compatible with flutter analyze
  runApp(ProviderScope(child: MainApp(initialLocation: initialLocation)));
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  final String? initialLocation;

  const MainApp({super.key, this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router(initialLocation: initialLocation),
    );
  }
}
