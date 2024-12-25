import 'package:easy_memo/data/ui/memo.dart';
import 'package:flutter/material.dart';

class ECalendar extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onPick;
  ECalendar({super.key, required this.selectedDate, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateFormat.format(selectedDate),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          child: Icon(Icons.calendar_month),
          onTap: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2024, 12, 1),
              lastDate: DateTime(2030, 1, 1),
            );

            if (newDate != null) {
              onPick(newDate);
            }
          },
        ),
      ],
    );
  }
}
