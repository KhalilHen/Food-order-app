import '../../core/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:hf_customer_app/controller/auth_controller.dart';
import 'package:hf_customer_app/models/user/account_profile.dart';
import 'package:hf_customer_app/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalInformation extends ConsumerStatefulWidget {
  const PersonalInformation({super.key});

  @override
  ConsumerState<PersonalInformation> createState() =>
      _PersonalInformationState();
}

class _PersonalInformationState extends ConsumerState<PersonalInformation> {
  final authController = AuthController();
  late TextEditingController nameController;

  // * Not used yet
  // late TextEditingController phoneNumberController;
  final formKey = GlobalKey<FormState>();

  AccountPersonalInformation? userData;
  bool formIsEddited = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();

    // * Not used yet
    // phoneNumberController = TextEditingController();
  }

  void openEmail() async {
    //Package code
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');
    }

    final Uri emailUrl = Uri(
      scheme: 'mailto',
      //TODO Change this later to the correct email
      path: 'support@halal-food.nl',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Nieuwe email aanvragen',
      }),
    );

    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      //TODO Find a way to let user know where to email for help when the user doesn't have an email app installed
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
 

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,

          child: Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
       

                TextFormField(
                  initialValue: user.value!.email,
                  enabled: false,

                  decoration: InputDecoration(
                    labelText: "Email",

                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ), // or your theme color
                    ),

                    labelStyle: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface, // Normal text color
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface, // Normal text color for input
                  ),
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vul iets in";
                    } else if (!value.contains('@')) {
                      return 'Vul een geldige email in';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Change email  ",
                        style: const TextStyle(color: Colors.black),

                        children: [
                          TextSpan(
                            text: "click here",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () => openEmail(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // * Not used yet
                // TextFormField(
                //   controller: phoneNumberController,

                //   decoration: const InputDecoration(
                //     labelText: "Telefoon-nummer",
                //     border: OutlineInputBorder(),
                //     prefixIcon: Icon(Icons.phone),
                //   ),

                //   onChanged: (value) => checkIfFormIsEdited(),

                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Vul iets in";
                //     }

                //     return null;
                //   },
                // ),

                // const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: formIsEddited == true
                      ? () async {
                          if (formKey.currentState!.validate()) {
                          }
                        }
                      : null,

                  child: const Text("Save changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    // * Not used yet
    // phoneNumberController.dispose();

    super.dispose();
  }
}
