import '../../core/utils/utils.dart';
import 'package:hf_customer_app/controller/auth_controller.dart';
import 'package:hf_customer_app/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void supportEmail() async {
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
      path: 'example@outlook.com',
      query: encodeQueryParameters(<String, String>{}),
    );

    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      //TODO Find a way to let user know where to email for help when the user doesn't have an email app installed
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user.value == null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              height: 600,
              width: 350,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(24),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.account_circle, size: 140),

                    const SizedBox(height: 8),

                    const Text(
                      "Sign in to your account ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("Log in to unlock the complete app"),

                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 10,
                        surfaceTintColor: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text('Acces your order history'),
                              leading: Icon(Icons.manage_accounts),
                            ),

                            ListTile(
                              title: Text(
                                'Manage your account settings',
                              ), //TODO
                              leading: Icon(Icons.manage_accounts),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent[200],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () => context.go('/login'),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFFE9ECEF),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () => context.go('/signup'),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w400),
        ), //! Perhaps  change this to normal instead of bold
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        // !! Perhaps use  this package later   https://pub.dev/packages/settings_ui
        // !! To give  both ios/android more native feel.
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),

              child: Text("Account settings"),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Personal data"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                context.push("/settings/personal-information", extra: user);
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Support"),
            ),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text("Support"),
              onTap: () async => supportEmail(),
            ),
            const ListTile(
              //!!  Add here a link to  FAQ
              leading: Icon(Icons.question_mark_sharp),
              title: Text("FAQ"),
            ),
            const ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("privacy policiy"),
            ),
            //TODO Verander het naar een soort plakken aan de bottom navbar soort lijn tekst met de app versie
            const ListTile(
              leading: Icon(Icons.verified_user_rounded),
              title: Text("App version"),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log  out"),
              onTap: () {
                AuthController().logOut();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
