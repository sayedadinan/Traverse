import 'package:flutter/material.dart';

class Dropdownmenu extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const Dropdownmenu({
    Key? key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<Dropdownmenu> createState() => _DropdownmenuState();
}

class _DropdownmenuState extends State<Dropdownmenu> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;

    // Check for duplicate values in the items list
    final uniqueValues = widget.items.toSet();
    if (uniqueValues.length != widget.items.length) {
      throw AssertionError(
        'Duplicate values found in the items list for Dropdownmenu.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<String>(
        dropdownColor: const Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.circular(6),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        underline: const SizedBox(),
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              dropdownValue = newValue;
              widget.onChanged(dropdownValue);
            });
          }
        },
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}

// class Dropdownmenu extends StatefulWidget {
//   final List<String> items;
//   final String initialValue;
//   final ValueChanged<String> onChanged;
//   const Dropdownmenu(
//       {super.key,
//       required this.items,
//       required this.initialValue,
//       required this.onChanged});

//   @override
//   State<Dropdownmenu> createState() => _DropdownmenuState();
// }

// class _DropdownmenuState extends State<Dropdownmenu> {
//   String dropdownValue = '';
//   @override
//   void initState() {
//     super.initState();
//     dropdownValue = widget.initialValue; // Set dropdownValue to initialValue
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//           border: Border.all(width: 1, color: Colors.black),
//           borderRadius: BorderRadius.circular(6)),
//       child: DropdownButton(
//         dropdownColor: const Color.fromARGB(255, 230, 230, 230),
//         borderRadius: BorderRadius.circular(6),
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         underline: const SizedBox(),
//         isExpanded: true,
//         value: dropdownValue,
//         onChanged: (String? newValue) {
//           setState(() {
//             dropdownValue = newValue!;
//             widget.onChanged(dropdownValue);
//             // selectedTravelPurpose = dropdownValue;
//           });
//         },
//         items: widget.items.map((String item) {
//           return DropdownMenuItem(
//             value: item,
//             child: Text(item),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
