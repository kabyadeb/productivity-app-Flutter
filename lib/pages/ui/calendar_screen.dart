import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePickerDialog(firstDate: DateTime.now(), lastDate: DateTime.now())
      ],
    );
  }
}
