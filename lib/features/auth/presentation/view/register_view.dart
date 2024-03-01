import 'dart:io';

import 'package:crimson_cycle/core/common/snackbar/my_snackbar.dart';
import 'package:crimson_cycle/core/theme/constants/fonts.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:crimson_cycle/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRegistrationState();
}

class _UserRegistrationState extends ConsumerState<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureConfirmTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);
        ref.read(authViewModelProvider.notifier).uploadImage(_img!);
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isConnected = ref.watch(connectivityStatusProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (isConnected == ConnectivityStatus.isDisconnected) {
      //   showSnackBar(
      //       message: 'No Internet Connection',
      //       context: context,
      //       color: Colors.red);
      // } else if (isConnected == ConnectivityStatus.isConnected) {
      //   showSnackBar(message: 'You are online', context: context);
      // }

      if (ref.watch(authViewModelProvider).showMessage!) {
        showSnackBar(message: 'User Registerd Successfully', context: context);
        ref.read(authViewModelProvider.notifier).resetMessage(false);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(231, 237, 245, 10),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Hey, \n",
                        style: titleFont,
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          width: 200,
                          child: CircleAvatar(
                            radius: 30,
                            // backgroundImage:
                            //     AssetImage('assets/images/profile.png'),
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage('assets/lady.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _fnameController,
                  validator: ValidateSignup.name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("First Name", style: normalFont),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "First Name",
                      hintStyle: normalFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lnameController,
                  validator: ValidateSignup.name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Last Name", style: normalFont),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Last Name",
                      hintStyle: normalFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: ValidateSignup.phone,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Phone number",
                        style: normalFont,
                      ),
                      prefixIcon: const Icon(Icons.phone),
                      hintText: "98xxxxxxxx",
                      hintStyle: normalFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _userNameController,
                  validator: ValidateSignup.username,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "User Name",
                        style: normalFont,
                      ),
                      prefixIcon: const Icon(Icons.person_pin),
                      hintText: "username",
                      hintStyle: normalFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidateSignup.emailValidate,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Email",
                        style: normalFont,
                      ),
                      prefixIcon: const Icon(Icons.email),
                      hintText: "xyz@gmail.com",
                      hintStyle: normalFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  validator: (String? value) => ValidateSignup.password(
                      value, _confirmPasswordController),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Password",
                      style: normalFont,
                    ),
                    prefixIcon: const Icon(Icons.password),
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
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obscureConfirmTextPassword,
                  controller: _confirmPasswordController,
                  validator: (String? value) =>
                      ValidateSignup.password(value, _passwordController),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Confirm Password",
                      style: normalFont,
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "xyz@_123",
                    hintStyle: normalFont,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmTextPassword =
                              !_obscureConfirmTextPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final entity = AuthEntity(
                            firstName: _fnameController.text,
                            lastName: _lnameController.text,
                            image:
                                ref.read(authViewModelProvider).imageName ?? "",
                            password: _passwordController.text,
                            email: _emailController.text,
                          );
                          // Register user
                          ref
                              .read(authViewModelProvider.notifier)
                              .registerUser(entity);
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pushNamed("/login");
                      });
                    },
                    child: const Text(
                      "Already have an account? Log in!",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ValidateSignup {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emailValidate(String? value) {
    final RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!emailValid.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return "Enter a correct 10-digit phone number";
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  static String? password(String? value, TextEditingController otherPassword) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password should be at least 8 characters";
    }
    if (otherPassword.text != value) {
      return "Passwords do not match";
    }
    return null;
  }
}
