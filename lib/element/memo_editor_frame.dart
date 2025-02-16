import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoEditorFrame extends StatelessWidget {
  final Widget titleEditor, contentEditor;
  final DateTime selectedDate;
  final DateFormat format = DateFormat("yyyy-MM-dd");

  MemoEditorFrame({
    super.key,
    required this.titleEditor,
    required this.contentEditor,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(5),
      ),
      // Date, Title, Content
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 11,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Date
              children: [
                Text(
                  "Date",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Text(
                  format.format(selectedDate),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
            ),
            height: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Date
              children: [
                Text(
                  "Title",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                SizedBox(
                  width: 100,
                  child: titleEditor,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
            ),
            height: 1,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: contentEditor,
          ),
        ],
      ),
    );
  }
}
