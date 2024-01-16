import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traverse_1/data/models/profile/user.dart';
import 'package:traverse_1/screens/intro_screens/login_page.dart';
import 'package:traverse_1/screens/home_page.dart';
import '../../data/functions/profile.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmpassController = TextEditingController();
  bool validateuser = false;
  bool validateemail = false;
  bool validatepassword = false;
  bool validateconfirm = false;

  File? imagepath;
  String? imagex;

  final formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool confirmpass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                const Text(
                  ' Glad to see You,\nCreate a account',
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                      final namePattern = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');

                      if (!namePattern.hasMatch(value)) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    controller: _userController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'User Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!isValidEmail(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      if (value.length <= 5) {
                        return "password minimum 6 letters ";
                      }
                      return null;
                    },
                    controller: _passController,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "confirm password is required";
                      } else if (_passController.text !=
                          _confirmpassController.text) {
                        return "password don't match";
                      }
                      if (value.length <= 5) {
                        return "password minimum 6 letters ";
                      }
                      return null;
                    },
                    controller: _confirmpassController,
                    obscureText: !confirmpass,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: ' Confirm Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmpass = !confirmpass;
                          });
                        },
                        icon: Icon(confirmpass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(350, 55),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addProfileclick(context);
                    }
                    log('heloooo');
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text('LOG IN'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> addProfileclick(BuildContext context) async {
    final nameExists = await checkIfNameExists(_userController.text);
    if (nameExists) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'This username is already registered. Please use a different username.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }
    setState(() {
      validateuser = _userController.text.isEmpty;
      validateemail =
          _emailController.text.isEmpty || !isValidEmail(_emailController.text);
      validatepassword = _passController.text.isEmpty;
      validateconfirm = _confirmpassController.text.isEmpty ||
          (_passController.text != _confirmpassController.text);
    });

    var user = Profile(
      username: _userController.text,
      email: _emailController.text,
      password: _passController.text,
      imagex: imagex.toString(),
    );

    int userId = await addProfile(user);
    user.id = userId;

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Homescreen(
          profileid: userId,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
