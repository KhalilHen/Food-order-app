import '../core/utils/utils.dart';

//TODO add everywhere the result class, and exception class
class AuthController {
  Future<Result<User?, Exception>> login(String email, String password) async {
    try {
      final AuthResponse response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      return Success(response.user, "Succesvol ingelogd");
    } catch (e, s) {
      final exception = e as Exception;
      return Failure(ExceptionHandler.handleException(e, s));
    }
  }

  //* Sign up with only email and password
  Future<Result<User?, Exception>> signUp(String email, String password) async {
    String? userId;
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception("Aanmelden faalde");
      }

      final userId = response.user!.id;

      await supabase.from('account').insert({
        'user_id': userId,
        'email': email,
      });

      return Success(response.user, 'Succesfully made a user');
    } catch (e, s) {
      final exception = e as Exception;
      return Failure(ExceptionHandler.handleException(e, s));
    }
  }

  void logOut() async {
    supabase.auth.signOut();
  }

  //! Currently not in use
  //TODO Refactor this for V2
  // Future<bool> sendPasswordResetEmail(String email) async {
  //   try {
  //     await supabase.auth.resetPasswordForEmail(email);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  //TODO Refactor this for V2
  // * Not used currently
  // Future<bool> updatePassword(
  //   String email,
  //   String password,
  //   String code,
  // ) async {
  //   try {
  //     await supabase.auth.verifyOTP(
  //       email: email,
  //       token: code,
  //       type: OtpType.recovery,
  //     );

  //     await supabase.auth.updateUser(UserAttributes(password: password));

  //     return true;
  //   } on AuthException {
  //     return false;
  //   } on PostgrestException {
  //     throw Exception(getPostgresException);
  //   } catch (e) {
  //     return false;
  //   }
  // }

}
