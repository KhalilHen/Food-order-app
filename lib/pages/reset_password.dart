import '../../core/utils/utils.dart';
import 'package:hf_customer_app/controller/auth_controller.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final tokenController = TextEditingController();
    final newPassword = TextEditingController();
    final authController = AuthController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),

          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Reset password", style: TextStyle()),
                  TextFormField(
                    controller: emailController,

                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill something in";
                      } else if (!value.contains('@')) {
                        return "Fill a valid email in";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),
                  TextFormField(
                    controller: tokenController,

                    decoration: const InputDecoration(
                      hintText: "32244242",
                      labelText: "Code",
                      prefixIcon: Icon(Icons.code),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill something in";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),
                  TextFormField(
                    controller: newPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Wachtwoord",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill something in";
                      }
                      if (value.length <= 6) {
                        return "Password is too weak minimum of 6 characters is required.";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm password",

                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " This field is required";
                      }
                      if (value != newPassword.text) {
                        return " Passwords  do not match";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      // !! Left out for V2
                      // final response = await   authController.updatePassword(emailController.text, tokenController.text,   newPassword.text);
                      //  if(response == true) {
                      //             if (!context.mounted) return;

                      //       context.push('/login');

                      //  } else {

                      //    const SnackBar(content: Text("Der ging iets fout probeer het opnieuw"));
                      //  }
                    },
                    child: const Text("Reset password"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
