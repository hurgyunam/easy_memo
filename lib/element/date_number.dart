import 'package:flutter/material.dart';

class DateNumber extends StatelessWidget {
  final int day;
  final bool isSelected;
  final void Function(int) onTap;
  final bool isToday;

  const DateNumber({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontColor = isToday
        ? Theme.of(context).colorScheme.background
        : isSelected
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.secondary;
    final backgroundColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : isToday
            ? Theme.of(context).colorScheme.primary.withAlpha(120)
            : Theme.of(context).colorScheme.background;

    final numberWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          day == 0 ? "" : day.toString(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: fontColor,
              ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        onTap(day);
      },
      child: numberWidget,
    );
  }
}
