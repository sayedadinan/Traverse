import 'package:flutter/material.dart';

class Elebuttons extends StatelessWidget {
  final String text;
  final Color butcolor;
  final Color textcolor;
  final Function function;
  const Elebuttons({
    Key? key,
    required this.text,
    required this.butcolor,
    required this.textcolor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          const Size(350, 55),
        ),
        backgroundColor: MaterialStateProperty.all(butcolor),
      ),
      onPressed: () {
        function();
        // Navigator.of(context).pop();
      },
      child: Text(
        text,
        style: TextStyle(color: textcolor, fontSize: 25),
      ),
    );
  }
}
