import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

List<Map<String, dynamic>> editcontactlist = [];
List<Map<String, dynamic>> companionList = [];

class Editcompanion extends StatefulWidget {
  final Tripmodel trip;
  final String text;
  final BuildContext context;
  final bool functionCheck;

  const Editcompanion({
    Key? key,
    required this.text,
    required this.context,
    this.functionCheck = false,
    required this.trip,
  }) : super(key: key);

  @override
  State<Editcompanion> createState() => _EditcompanionState();
}

class _EditcompanionState extends State<Editcompanion> {
  Future<void> selectCompanions() async {
    try {
      final contact = await FlutterContactPicker.pickPhoneContact();

      if (contact == null) {
        // User canceled contact picking
        print('User canceled picking a contact');
        return;
      }

      String companionName = contact.fullName ?? '';
      String companionNumber = contact.phoneNumber?.number ?? '';
      if (companionName.isNotEmpty && companionNumber.isNotEmpty) {
        editcontactlist.add({
          "name": companionName,
          "number": companionNumber,
        });

        print('$companionName==$companionNumber');
        print('added ${editcontactlist.length}');
      } else {
        print('List is Empty');
      }
    } catch (e) {
      print('Error picking contact: $e');
    }
  }

  Future<void> showCompanions() async {
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
                  final companion = editcontactlist[index];
                  if (companion != null &&
                      companion.containsKey("name") &&
                      companion.containsKey("number")) {
                    return Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(239, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              editcontactlist.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
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
                itemCount: editcontactlist.length,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void onTapFunction() {
      widget.functionCheck ? selectCompanions() : showCompanions();
    }

    return InkWell(
      onTap: onTapFunction,
      child: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width * 0.43,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 40, 57, 41),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Icon(
                Icons.group,
                color: Colors.amber,
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 40, 57, 41),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
