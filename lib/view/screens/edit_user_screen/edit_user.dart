import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/data/models/profile/user.dart';
import 'package:traverse_1/view/util/user_edit_screen_funtion.dart';

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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => FormValidation.validateName(value),
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) => FormValidation.validateEmail(value),
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
                      validator: (value) =>
                          FormValidation.validatePassword(value),
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 244, 241, 241),
                        filled: true,
                        labelText: 'password',
                        hintText: 'Enter your new password',
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
                          UserEditFunction.editProfileClicked(
                            context,
                            _formKey,
                            widget.profileid,
                            imagePath,
                            nameController.text,
                            emailController.text,
                            newPasswordController.text,
                          );
                        },
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                              color: Color.fromARGB(255, 9, 108, 60),
                              fontSize: 25),
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
}
