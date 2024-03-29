import 'package:flutter/material.dart';
import 'package:traverse_1/view/screens/signup_screen/sign_up_page.dart';
import 'package:traverse_1/view/util/login_screen_function.dart';

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
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 3, 70, 37)),
              ),
              const Text(' enter your account username and\n password.'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username is required";
                    }
                    return null;
                  },
                  controller: _userController,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is required";
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
                      fixedSize: MaterialStateProperty.all(const Size(350, 55)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[300])),
                  onPressed: () {
                    login();
                  },
                  child: const Text('LOGIN',
                      style: TextStyle(color: Color.fromARGB(255, 3, 70, 37)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont'have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Signup()));
                      },
                      child: const Text('SIGN UP')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    LoginscreenFunctions.login(
      context,
      formKey,
      _userController,
      _passController,
    );
  }
}
