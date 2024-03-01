import 'package:crimson_cycle/core/theme/constants/fonts.dart';
import 'package:crimson_cycle/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureTextPassword = true;
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _authViewModel = ref.read(authViewModelProvider.notifier);
    _authViewModel.loginNavigator.context = context;
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  showHidePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print("List of available Biometrics :$availableBiometrics");

    if (!mounted) {
      return;
    }
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint to login",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        const String email = "testuser@gmail.com";
        const String password = "testuser";

        // Set predefined credentials
        _emailController.text = email;
        _passwordController.text = password;

        if (context.mounted) {
          await ref.read(authViewModelProvider.notifier).loginUser(
                context,
                _emailController.text,
                _passwordController.text,
              );
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(231, 237, 245, 10),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.3,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hey, \n",
                      style: titleFont,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidateLogin.emailValidate,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text(
                          "Enter your email",
                          style: normalFont,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        ),
                        hintText: "xyz@gmail.com",
                        hintStyle: normalFont),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: ValidateLogin.password,
                    obscureText: _obscureTextPassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Password",
                        style: normalFont,
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.blueGrey,
                      ),
                      hintText: "xyz@_123",
                      hintStyle: normalFont,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPassword = !_obscureTextPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pushNamed("/ForgotPassword");
                          });
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: 'Forgot Password?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // logIn(context);
                                  await ref
                                      .read(authViewModelProvider.notifier)
                                      .loginUser(
                                        context,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                }
                              },
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pushNamed("/register");
                              });
                            },
                            child: const Text(
                              "New to the app? Sign up!",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          )
                        ],
                      )),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_supportState)
                          const Text("This device supports biometrics")
                        else
                          const Text("This device doesnot support biometrics"),
                        ElevatedButton(
                            onPressed: _authenticate,
                            child: const Text("Authenticate"))
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
}

class ValidateLogin {
  static String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }
}
