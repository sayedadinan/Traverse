// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

List<Map<String, dynamic>> companionList = [];

class MyCompanion extends StatelessWidget {
  final String text;
  final BuildContext context;
  final bool functionCheck;
  const MyCompanion(
      {super.key,
      required this.text,
      required this.context,
      this.functionCheck = false});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void onTapFunction() {
      functionCheck ? selectCompanions() : showCompanions();
    }

    return InkWell(
      onTap: onTapFunction,
      child: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width * 0.43,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 40, 57, 41)),
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Icon(
                Icons.group,
                color: Colors.amber,
              ),
              Text(
                text, // Display selected date or 'Starting date'
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 40, 57, 41)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectCompanions() async {
    try {
      final contact = await FlutterContactPicker.pickPhoneContact();

      if (contact == null) {
        // User canceled contact picking
        return;
      }

      String companionName = contact.fullName ?? '';
      String companionNumber = contact.phoneNumber?.number ?? '';
      if (companionName.isNotEmpty && companionNumber.isNotEmpty) {
        companionList.add({
          "name": companionName,
          "number": companionNumber,
        });
      } else {}
    } catch (e) {
      log(-1);
    }
  }

  Future<dynamic> showCompanions() async {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 207, 207, 207),
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final companion = companionList[index];
                  if (companion != null &&
                      companion.containsKey("name") &&
                      companion.containsKey("number")) {
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(239, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                companionList.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        title: Text(companion["name"]?.toUpperCase() ?? ""),
                        subtitle: Text(companion["number"] ?? ""),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: companionList.length,
              );
            },
          ),
        );
      },
    );
  }
}
