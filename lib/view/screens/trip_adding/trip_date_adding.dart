import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traverse_1/view/screens/trip_adding/trip_details_adding.dart';
import 'package:intl/intl.dart';
import '../../../components/elevatedbuttons.dart';
import '../../../components/trip_widgets/textfields.dart';

class AddDate extends StatefulWidget {
  final int profileid;
  const AddDate({Key? key, required this.profileid}) : super(key: key);

  @override
  State<AddDate> createState() => _AddDateState();
}

DateFormat dateFormat = DateFormat('dd-MMM-yyyy');

class _AddDateState extends State<AddDate> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  late DateTime? _rangeStart;
  late DateTime? _rangeEnd;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = null;
    _rangeStart = null;
    _rangeEnd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add tour'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TableCalendar(
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2021, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  onDaySelected: (selectedDay, focusedDay) {
                    final now = DateTime.now();
                    if (selectedDay.isAfter(now) ||
                        dateFormat.format(selectedDay) ==
                            dateFormat.format(now)) {
                      setState(() {
                        if (_rangeStart == null) {
                          _rangeStart = selectedDay;
                          _rangeEnd = null;
                          _startDateController.text =
                              dateFormat.format(selectedDay);
                        } else if (_rangeEnd == null ||
                            selectedDay.isBefore(_rangeStart!)) {
                          _rangeEnd = selectedDay;
                          _endDateController.text =
                              dateFormat.format(selectedDay);
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          padding: EdgeInsets.all(24),
                          backgroundColor: Colors.amber,
                          content: Text('Please select a future date.'),
                        ),
                      );
                    }
                  },
                  calendarStyle: const CalendarStyle(
                    rangeStartDecoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                Inputfield(
                  controller: _startDateController,
                  hinttext: 'Starting Date',
                  label: 'Start Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a starting date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Inputfield(
                  controller: _endDateController,
                  hinttext: 'Ending date',
                  label: 'End Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an ending date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Elebuttons(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Back',
                  butcolor: Colors.grey,
                  textcolor: Color.fromARGB(255, 9, 108, 60),
                ),
                const SizedBox(
                  height: 22,
                ),
                Elebuttons(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Addtripdetail(
                          profileid: widget.profileid,
                          startDateController: _startDateController,
                          endDateController: _endDateController,
                        ),
                      ));
                    }
                  },
                  text: 'Next',
                  butcolor: const Color.fromARGB(255, 93, 228, 215),
                  textcolor: Color.fromARGB(255, 9, 108, 60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
