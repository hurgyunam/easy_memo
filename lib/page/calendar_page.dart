import 'package:flutter/material.dart';

import '../element/ECalendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: ECalendar(
              selectedDate: selectedDate,
              onPick: (value) {
                setState(() {
                  selectedDate = value;
                });
              },
            ),
          ),
          Text("메모13"),
          Text("메모2"),
          Text("메모3"),
          Text("메모4"),
          Text("메모5"),
        ],
      ),
    );
  }
}
