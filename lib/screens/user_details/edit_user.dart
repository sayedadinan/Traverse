import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/data/models/profile/user.dart';

class Edituser extends StatefulWidget {
  final Profile profileid;
  const Edituser({super.key, required this.profileid});

  @override
  State<Edituser> createState() => _EditmailState();
}

class _EditmailState extends State<Edituser> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String? imagePath;
  File? profileimage;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.profileid.username;
    emailController.text = widget.profileid.email;
    // passController.text = widget.profileid.password;
    newPasswordController.text = widget.profileid.password;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: profileData,
          builder: (context, value, child) => Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     pickImageFromGallery();
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 70,
                      //     backgroundColor: Colors.transparent,
                      //     backgroundImage: selectedImage != null
                      //         ? FileImage(selectedImage!)
                      //         : value.first.imagex != null &&
                      //                 File(value.first.imagex!).existsSync()
                      //             ? FileImage(File(value.first.imagex!)) as ima
                      //             : const AssetImage(
                      //                 'assets/user.png',
                      //               ),
                      //   ),
                      // )
                      GestureDetector(
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: value.first.imagex != null &&
                                  File(value.first.imagex!).existsSync()
                              ? FileImage(File(value.first.imagex))
                                  as ImageProvider<Object>?
                              : const AssetImage(
                                  'assets/user.png',
                                ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 244, 241, 241),
                        filled: true,
                        labelText: 'user name',
                        hintText: 'Enter your name',
                        // errorText: validateuser ? 'value cant be Empty' : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Name';
                        }
                        if (value.length >= 16) {
                          return "Name is too long";
                        }
                        return null;
                      },
                      // textcontent: 'Full Name',
                      // keyType: TextInputType.name,
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!isValidEmail(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 244, 241, 241),
                        filled: true,
                        labelText: 'Email',
                        hintText: 'Enter your new email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length <= 5) {
                          return "password minimum 6 letters ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 244, 241, 241),
                        filled: true,
                        labelText: 'password',
                        hintText: 'Enter your new password',

                        // errorText: validateuser ? 'value cant be Empty' : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: newPasswordController,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.09,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(350, 55),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.teal[200],
                          ),
                        ),
                        onPressed: () {
                          editProfileClicked(context);
                          // Navigator.of(context).pop();
                        },
                        child: Text(
                          'UPDATE',
                          style:
                              TextStyle(color: Colors.green[800], fontSize: 25),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      profileimage = File(returnedImage.path);
      imagePath = returnedImage.path.toString();
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> editProfileClicked(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String newPassword = newPasswordController.text;
      String existingPassword = passController.text;
      if (newPassword.isNotEmpty && newPassword != existingPassword) {
        await editProfiledata(
          widget.profileid.id,
          imagePath,
          nameController.text.toLowerCase(),
          emailController.text.toLowerCase(),
          newPassword,
        );

        refreshRefreshid(widget.profileid.id!);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        // Show an error message if the new password is the same as the existing password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'New password should be different from the existing password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
