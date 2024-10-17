import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:video_conference_app/Screens/Auth/login.dart';
import 'package:video_conference_app/Screens/Home/bnb.dart';
import 'package:video_conference_app/Widgets/auth_widgets.dart';
import 'package:video_conference_app/Widgets/snackbar.dart';
import 'package:video_conference_app/constants/assets_path.dart';
import 'package:video_conference_app/services/auth_services.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late AuthService _authService;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoadingSignup = false;
  bool viewPassword = false;
  bool isLoadingGoogle = false;

   @override
  void initState() {
    _authService = GetIt.instance.get<AuthService>();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context,
        "Create Account",
        const LoginScreen(),
        "Or Login",
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _signupForm(context),
            otherSigninMethods(context, _authService),
          ],
        ),
      ),
    );
  }

  Widget _signupForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextField(name, "Full Name", personIcon,
                isNameField: true, errorText: "Enter valid full name"),
            customTextField(
                email, "Email or Phone Number", emailIcon,
                isEmailField: true, errorText: "Enter valid email address"),
            customTextField(
              password,
              "Password",
              passwordIcon,
              isPasswordField: !viewPassword,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      viewPassword = !viewPassword;
                    });
                  },
                  icon: Icon(
                    (viewPassword)
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  )),
            ),
            authButton(
              "Create Account",
              () {
                _onTapSignup();
              },
              isLoadingSignup,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoadingSignup = true;
      });
      try {
        bool result = await _authService.signup(name.text, email.text, password.text, ref);
        if (result) {
          snackbarToast(
            context: context,
            title: "Account Created Sucessfully",
            icon: Icons.login_outlined,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Bnb()),
          );
          setState(() {
            isLoadingSignup = false;
          });
        } else {
          setState(() {
            isLoadingSignup = false;
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          isLoadingSignup = false;
        });
      }
    }
  }

  Widget gotoLogin(BuildContext context) {
    return Row(
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: () {},
          child: const Text("Login"),
        ),
      ],
    );
  }
}

Widget otherSigninMethods(
  BuildContext context,
  AuthService authService,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
            SizedBox(width: 7),
            Text(
              "Or use other methods",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(width: 7),
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton(
          onPressed: () async {
            // Handle Google sign in
            await authService.handleGoogleSignIn().then((value) {
              if (value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Bnb()),
                );
              }
            });
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                googleImage,
                width: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Sign Up with Google',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
