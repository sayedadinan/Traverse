import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/data/models/profile/user.dart';

class UserEditFunction {
  static Future<void> editProfileClicked(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Profile profile,
    String? imagePath,
    String name,
    String email,
    String newPassword,
  ) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      // Check if the newPassword is not empty and different from the current password
      bool updatePassword =
          newPassword.isNotEmpty && newPassword != profile.password;

      await editProfiledata(
        profile.id,
        imagePath,
        name.toLowerCase(),
        email.toLowerCase(),
        updatePassword
            ? newPassword
            : profile
                .password, // Use newPassword if updatePassword is true, else use the existing password
      );

      refreshRefreshid(profile.id!);

      Navigator.of(context).pop();
    }
  }
}

Future<File?> pickImageFromGallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage == null) return null;
  return File(pickedImage.path);
}

class FormValidation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Name';
    }
    if (value.length >= 16) {
      return "Name is too long";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length <= 5) {
      return "password minimum 6 letters ";
    }
    return null;
  }

  static bool isValidEmail(String email) {
    // Add your email validation logic here
    // For simplicity, we're just checking for the presence of '@'
    return email.contains('@');
  }
}
