import 'package:hf_customer_app/core/routes/guard.dart';
import 'package:hf_customer_app/core/utils/utils.dart';
import 'package:hf_customer_app/provider/user_provider.dart';

class AuthGuard  extends ConsumerWidget {


  final String fallbackRoute;
  final Widget child;

    const AuthGuard({
    super.key,
    required this.fallbackRoute,
    required this.child,
  });

    @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(userProvider);
    return Guard(
canActivate: Future.value(authState.value != null),

      fallbackRoute: fallbackRoute,
      child: child,
    );
  }
}