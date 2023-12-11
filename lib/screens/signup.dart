import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/models/profile/user.dart';
// import 'package:traverse_1/screens/home.dart';
import 'package:traverse_1/screens/login.dart';
import 'package:traverse_1/screens/home.dart';

import '../data/functions/profile.dart';
// import 'login.dart';

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
                // const Text(
                //   'Glad to see You,\nmake account',
                //   style: TextStyle(
                //     fontSize: 32,
                //     fontWeight: FontWeight.w500,
                //     color: Color.fromARGB(255, 37, 62, 207),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: const CircleAvatar(
                    radius: 80,
                    // backgroundImage: AssetImage('assets/car traverse.png'),
                  ),
                ),
                const SizedBox(
                  height: 17,
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
                      errorText: validateuser ? 'value cant be Empty' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // child: TextFormField(
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "username is required";
                  //     }
                  //     return null;
                  //   },
                  //   controller: _userController,

                  //   // keyboardType: TextInputType.visiblePassword,
                  //   // obscureText: true,
                  //   decoration: InputDecoration(
                  //     fillColor: const Color.fromARGB(255, 244, 241, 241),
                  //     filled: true,
                  //     labelText: 'user name',
                  //     hintText: 'Enter your name',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email is required";
                      }
                      return null;
                    },
                    controller: _emailController,

                    // keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      errorText: validateemail ? 'value cant be Empty' : null,
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
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "password is required";
                    //   }
                    //   return null;
                    // },
                    controller: _passController,

                    // keyboardType: TextInputType.visiblePassword,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'password',
                      hintText: 'Enter your password',
                      errorText:
                          validatepassword ? 'value cant be Empty' : null,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      } else if (_passController.text !=
                          _confirmpassController.text) {
                        return "password don't match";
                      }
                      return null;
                    },
                    controller: _confirmpassController,

                    // keyboardType: TextInputType.visiblePassword,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: ' confirm password',
                      hintText: 'Enter your password',
                      errorText: validateconfirm ? 'value cant be Empty' : null,
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
                    // if (formKey.currentState!.validate()) {}
                    log('heloooo');
                    addProfileclick(context);
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

  Future<void> addProfileclick(BuildContext context) async {
    final nameExists = await checkIfNameExists(_userController.text);
    if (nameExists) {
      // Show an error message if the username already exists in the database.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'This username is already registered. Please use a different username.'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    setState(() {
      _userController.text.isEmpty ? validateuser = true : validateuser = false;
      _emailController.text.isEmpty
          ? validateemail = true
          : validateemail = false;
      _passController.text.isEmpty
          ? validatepassword = true
          : validatepassword = false;
      _confirmpassController.text.isEmpty
          ? validateconfirm = true
          : validateconfirm = false;
    });
    if (validateuser == false &&
        validateemail == false &&
        validatepassword == false &&
        validateconfirm == false &&
        validateconfirm == validatepassword) {
      var user = Profile(
          username: _userController.text,
          email: _emailController.text,
          password: _passController.text,
          imagex: imagex.toString());
      // final nameExists = await checkIfNameExists(username);
      int userId = await addProfile(user);
      user.id = userId;

      // final result = addProfile(user);
      // print(result);
      // Navigator.pop(context, result);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Homescreen(),
        ),
      );
    }
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      imagepath = File(returnedImage.path);
      imagex = imagepath.toString();
    });
  }
}
