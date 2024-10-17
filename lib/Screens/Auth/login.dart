import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:video_conference_app/Screens/Auth/signup.dart';
import 'package:video_conference_app/Screens/Home/bnb.dart';
import 'package:video_conference_app/Widgets/auth_widgets.dart';
import 'package:video_conference_app/Widgets/snackbar.dart';
import 'package:video_conference_app/services/auth_services.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late AuthService _authService;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoadingLogin = false;
  bool viewPassword = false;
  bool isLoadingGoogle = false;

  @override
  void initState() {
    _authService = GetIt.instance.get<AuthService>();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context,
        "Login Account",
        const SignupScreen(),
        "Or Signup",
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
            _loginForm(context),
            otherSigninMethods(context, _authService),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextField(
                email, "Email or Phone Number", "assets/icons/mail.png",
                isEmailField: true, errorText: "Enter valid email address"),
            customTextField(
              password,
              "Password",
              "assets/icons/password.png",
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
              "Login Account",
              () {
                _onTapLogin();
              },
              isLoadingLogin,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoadingLogin = true;
      });
      try {
        await _authService.login(email.text, password.text, ref).then((value) {
          if (value) {
            snackbarToast(
              context: context,
              title: "Login Sucessfully",
              icon: Icons.login_outlined,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Bnb()),
            );
            setState(() {
              isLoadingLogin = false;
            });
          } else {
            setState(() {
              isLoadingLogin = false;
            });
          }
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoadingLogin = false;
        });
      }
    }
  }
}
