import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hf_customer_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProvider = StreamProvider<User?>((ref) async* {
  final authStream = supabase.auth.onAuthStateChange;
  //the function then returns the account object.

  await for (final authState in authStream) {
    yield authState.session?.user;
  }
});
