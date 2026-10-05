import 'dart:io';

import 'package:hf_customer_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExceptionHandler implements Exception {
  static String handleException(Object error, [StackTrace? stackTrace]) {
    print(error);
    return switch (error) {
      AuthApiException() => _handleAuthException(error),
      PostgrestException() => _handleDatabaseExceptions(error),

      StorageException() => _handleStorageExceptions(error),
      SocketException() => 'No internet connection',
      UserNotAuthenticatedException() =>
        'You need to be logged in for this action',

      _ => 'Something unexpected  went wrong try it again + $error',
    };
  }
}

String _handleAuthException(AuthApiException e) {
  return switch (e.code) {
    'invalid_credentials' => 'Login failed invalid email or password',

    'email_exists' => 'This email already exist',

    'email_not_confirmed' =>
      'This email is not confirmed yet confirm your email to continue',
    'not_admin' => 'Sorry you dont have the right permission for this',

    'over_email_send_rate_limit' =>
      'You have exceeded the email sending limit. Please wait a few minutes before trying again',

    'over_request_rate_limit' => 'Sorry wait  a few mins and try again',

    // ! Currently not used
    //    'phone_exists' => '',
    //  'phone_not_confirmed' => '',
    'same_password' =>
      'Your new password can\'t be the same as the old passowrd',
    'user_already_exists' =>
      'An account with this information already exists. Please log in',
    _ => 'Sorry there went something wrong',
  };
}

String _handleDatabaseExceptions(PostgrestException e) {
  print(e);
  return switch (e.code) {
    '08*' =>
      'Sorry there went something wrong with establishing a connection with the server',

    '23505' => '',
    _ => 'There went something wrong + $e' ,
  };
}

String _handleStorageExceptions(StorageException e) {
  //* Here you can create logs based on certain exceptions that happen so that you get a notifcation when something goes wrong
  print(e);
  return switch (e.statusCode) {
    _ => 'Sorry there went something wrong',
  };
}
