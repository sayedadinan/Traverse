import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/profile.dart';
import 'package:traverse_1/view/screens/edit_user_screen/edit_user.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Edituser(
                                  profileid: value.first,
                                )));
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: value.first.imagex != null &&
                                File(value.first.imagex!).existsSync()
                            ? FileImage(File(value.first.imagex!))
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
                ListTile(
                  leading: const Icon(
                    Icons.account_box_outlined,
                    size: 30,
                  ),
                  title: const Text(
                    'Name',
                    style: TextStyle(fontSize: 26),
                  ),
                  subtitle: Text(
                    value.first.username,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                ListTile(
                  leading: const Icon(
                    Icons.mail_outline,
                    size: 30,
                  ),
                  title: const Text(
                    'Mail',
                    style: TextStyle(fontSize: 26),
                  ),
                  subtitle: Text(
                    value.first.email,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                ListTile(
                  leading: const Icon(
                    Icons.lock,
                    size: 30,
                  ),
                  title: const Text(
                    'Password',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text(
                    value.first.password,
                    style: const TextStyle(fontSize: 20),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Edituser(
                                  profileid: value.first,
                                )));
                      },
                      child: Text(
                        'Edit User',
                        style: TextStyle(
                            color: Color.fromARGB(255, 9, 108, 60),
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Save User',
                        style: TextStyle(
                            color: Color.fromARGB(255, 9, 108, 60),
                            fontSize: 25),
                      ),
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
}
