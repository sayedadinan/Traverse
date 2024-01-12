import 'package:flutter/material.dart';

class MyChoiceChip extends StatefulWidget {
  final List<String> choices = [
    'Flight',
    'Car ',
    'Train',
    'Bike  ',
    'Ship',
    'Other'
  ];
  final List<Icon> icons = [
    const Icon(Icons.flight_takeoff_rounded),
    const Icon(Icons.directions_car_rounded),
    const Icon(Icons.train_rounded),
    const Icon(Icons.directions_bike_rounded),
    const Icon(Icons.directions_boat),
    const Icon(Icons.commute),
  ];
  final ValueChanged<String>? onChipSelected;
  MyChoiceChip({Key? key, this.onChipSelected}) : super(key: key);

  @override
  State<MyChoiceChip> createState() => _MyChoiceChipState();
}

class _MyChoiceChipState extends State<MyChoiceChip> {
  int? _value;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.generate(
        widget.choices.length,
        (int index) {
          return SizedBox(
            height: 50,
            width: 123,
            child: ChoiceChip(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              avatar: widget.icons[index],
              selectedColor: Colors.amber,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 37, 62, 207),
                size: 17,
              ),
              labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 37, 62, 207), fontSize: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(width: 1)),
              label: Text(widget.choices[index]),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                  // _value != null ? selected = true : null;
                  if (selected) {
                    widget.onChipSelected?.call(widget.choices[index]);
                  }
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
