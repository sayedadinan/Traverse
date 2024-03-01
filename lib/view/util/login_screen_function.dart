import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/view/screens/home_page.dart';

class LoginscreenFunctions {
  static Future<void> login(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController userController,
      TextEditingController passController) async {
    if (formKey.currentState!.validate()) {
      final username = userController.text;
      final password = passController.text;

      final user = await validateprofile(username, password);
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => Homescreen(
                    profileid: user.id!,
                  )),
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

class Apperrors {
  static const String invalidLogin =
      'Invalid Login. Please check your username and password.';
  static const String networkError =
      'Network Error. Please check your internet connection.';
}
