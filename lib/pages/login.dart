import 'package:hf_customer_app/controller/auth_controller.dart';
import '../core/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      appBar: AppBar(),
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
                    'Welcome back',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    textAlign: TextAlign.start,
                    "Sign in to continue!",
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    key: const Key("emailField"),
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validator().validateEmail(value!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key("passwordField"),

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

                      return null;
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 40),
                      TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: const Text(
                          "Forgot password?",
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
                        if (formKey.currentState!.validate()) {
                          final response = await authController.login(
                            emailController.text,
                            passwordController.text,
                          );

                          final value = switch (response) {
                            Success() => UIHelper.navigateTo(
                              context,
                              '/restaurants',
                              NavigationType.go,
                              null,
                            ),

                            Failure() =>
                              //! Hier moet misschien als nog een guard bescherming
                              UIHelper.showError(context, response.message),
                          };
                        }
                      },
                      child: const Text(
                        'Login',
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
