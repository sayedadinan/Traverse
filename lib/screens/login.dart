import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/screens/home.dart';
import 'package:traverse_1/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your details',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
              ),
              const Text(' enter your account username and\n password.'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username is required";
                    }
                    return null;
                  },
                  controller: _userController,

                  // keyboardType: TextInputType.visiblePassword,
                  // obscureText: true,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    filled: true,
                    labelText: 'user name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is required";
                    }
                    return null;
                  },
                  controller: _passController,

                  // keyboardType: TextInputType.visiblePassword,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    filled: true,
                    labelText: 'password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off),
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
                    const Color.fromARGB(255, 37, 62, 207),
                  ),
                ),
                onPressed: () {
                  login();
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont'have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Signup(),
                        ),
                      );
                    },
                    child: const Text('SIGN UP'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final username = _userController.text;
      final password = _passController.text;

      final user = await validateprofile(username, password);
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Homescreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Invalid Login. Please check your username and password'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
