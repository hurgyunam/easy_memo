import 'package:flutter/material.dart';

class PageCalendar extends StatefulWidget {
  const PageCalendar({super.key});

  @override
  State<PageCalendar> createState() => _PageCalendarState();
}

class _PageCalendarState extends State<PageCalendar> {
  @override
  Widget build(BuildContext context) {
    const List<String> weekDays = [
      "SUN",
      "MON",
      "TUE",
      "WED",
      "THU",
      "FRI",
      "SAT"
    ];

    final now = DateTime.now();
    final monthStartDay = DateTime(now.year, now.month, 1);
    final monthLastDay = DateTime(now.year, now.month + 1, 0);

    final dateNumbers = [];

    for (var i = 0; i < monthStartDay.weekday; i++) {
      dateNumbers.add(0);
    }

    for (var i = 1; i <= monthLastDay.day; i++) {
      dateNumbers.add(i);
    }

    final memoTitles = [
      "2025-02-01 13:50:23",
      "티끌 가사 컨셉",
      "눈을 낮춰 지금의 나를 보다 컨셉",
      "2025-02-01 16:21:03",
      "2025-02-01 18:00:00",
    ];

    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                //date
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      // Date
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 11,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          Text(
                            "2025-02-01",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Container(
                      // Date
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 11,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Febrary 2025",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                            children: [
                              ...weekDays.map((date) {
                                return Center(
                                  child: Text(
                                    date,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                  ),
                                );
                              }),
                              ...dateNumbers.map((date) {
                                return Center(
                                  child: Text(
                                    date == 0 ? "" : date.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                );
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Container(
                //memo list
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  // list
                  children: [
                    ...memoTitles.map((title) {
                      final isLast =
                          memoTitles.indexOf(title) == memoTitles.length - 1;

                      return Container(
                        // list item
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: isLast
                                ? BorderSide.none
                                : BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 0.3,
                                  ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Expanded(
                                child: Text(title),
                              ),
                            ),
                            Container(
                              width: 0.3,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
