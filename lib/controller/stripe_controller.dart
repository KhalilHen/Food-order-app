import 'package:flutter_stripe/flutter_stripe.dart';
import '../core/utils/utils.dart';

class StripeController {
  // !! For now i receive the order price from the order function
  // ! But next version it should fetch the price from the database
  // ! via the edge function to prevent malicious manipulation
  Future<Result<Null, Exception>> createPaymentIntent(
    User? user,
    num totalAmount,
  ) async {

    print(user);
    final res = await supabase.functions.invoke(
      'create-payment-intent',
      body: {'totalAmount': totalAmount},
    );
    final data = res.data;
    if (data == null) {
      return const Failure("There went something wrong");
  } else {
      print(data);
      final response = await intializePaymentSheet(data);

      if (response case Failure()) {
        return const Failure("");
      }

      return const Success(null, null);
    }
  }

  Future<Result<Null, Exception>> intializePaymentSheet(
    String clientSecret,
  ) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Food-app",
          primaryButtonLabel: 'Pay now',
          style: ThemeMode.dark,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'EU',
            testEnv: true,
          ),
        ),
      );
      return const Success(null, null);
    } on StripeException catch (e, s) {
      print(e.error.localizedMessage);
      print(e.error.message);
      return Failure(ExceptionHandler.handleException(e, s).toString());
    }
  }

  Future<Result<Null, Exception>> confirmPayment(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successfully completed')),
      );

      return const Success(null, "Payment successfully completed");
    } on StripeException catch (e, s) {
      //TODO Check in future if i need to make custom exceptions message from the StripeExceptions
      final exception = e as Exception;
      return Failure(ExceptionHandler.handleException(e, s));
    }
  }
}
