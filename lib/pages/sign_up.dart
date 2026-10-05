import '../../core/utils/utils.dart';
import 'package:hf_customer_app/controller/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = AuthController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ! For now not used
      // persistentFooterButtons: const [
      //   Text.rich(
      //     textAlign: TextAlign.center,
      //     TextSpan(
      //       children: [
      //         TextSpan(text: "By continuing you agree to our "),
      //         TextSpan(text: "Terms and service"),
      //       ],
      //     ),
      //   ),
      // ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 32),

                  TextFormField(
                    key: const Key('emailField'),

                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill something in";
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('passwordField'),

                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Fill something in";
                      }
                      if (value.length <= 6) {
                        return "Password is too  weak fill  a minimum 6 characters in";
                      }

                      return null;
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          "Login",

                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent[200],
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final response = await authController.signUp(
                            emailController.text,
                            passwordController.text,
                          );

                          switch (response) {
                            case Success():
                              UIHelper.navigateTo(
                                context,
                                '/login',
                                NavigationType.go,
                                null,
                              );

                            case Failure():
                              UIHelper.showError(context, response.message);
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
