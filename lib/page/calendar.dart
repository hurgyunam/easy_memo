import 'package:easy_memo/data/memo.dart';
import 'package:easy_memo/element/date_number.dart';
import 'package:easy_memo/popup/edit_popup.dart';
import 'package:easy_memo/popup/history_list_popup.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../popup/create_history_memo_popup.dart';

class PageCalendar extends ConsumerStatefulWidget {
  const PageCalendar({super.key});

  @override
  ConsumerState<PageCalendar> createState() => _PageCalendarState();
}

class _PageCalendarState extends ConsumerState<PageCalendar> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  List<Memo> memos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadByDate(selectedDate);
  }

  Future<void> loadByDate(DateTime date) async {
    final memos =
        await ref.read(memoStorageProvider).loadByDate(date: selectedDate);

    setState(() {
      this.memos = memos;
    });
  }

  Future<void> onTapMemoListItem(Memo memo) async {
    final savedMemoId =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditPopup(
        memoId: memo.memoId,
        title: memo.title,
        content: memo.title,
        date: memo.date,
      );
    }));

    if (savedMemoId != null) {
      loadByDate(selectedDate);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모가 수정되었습니다.")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모를 수정하는 중 에러가 발생했습니다.")));
    }
  }

  Future<void> onTapCreateHistory(Memo memo) async {
    final savedMemoId =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateHistoryMemoPopup(
        rootMemoId: memo.memoId,
        rootMemoTitle: memo.title,
      );
    }));

    if (savedMemoId != null) {
      loadByDate(selectedDate);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모가 추가되었습니다.")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모를 추가하는 중 에러가 발생했습니다.")));
    }
  }

  Future<void> onTapViewHistory(Memo memo) async {
    final historyId = memo.historyId;

    if (historyId != null) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HistoryListPopup(
          historyId: historyId,
        );
      }));

      loadByDate(selectedDate);
    } else {
      throw Exception("히스토리 리스트를 접근하는데 있어 올바르지 않은 접근입니다. $historyId");
    }
  }

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

    final List<int> dateNumbers = [];

    for (var i = 0; i < monthStartDay.weekday; i++) {
      dateNumbers.add(0);
    }

    for (var i = 1; i <= monthLastDay.day; i++) {
      dateNumbers.add(i);
    }

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
                            dateFormat.format(selectedDate),
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
                                return DateNumber(
                                  day: date,
                                  isSelected: date == selectedDate.day,
                                  onTap: (int day) {
                                    setState(() {
                                      selectedDate =
                                          selectedDate.copyWith(day: day);
                                    });
                                    loadByDate(selectedDate);
                                  },
                                  isToday: date == now.day,
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
                    ...memos.map((memo) {
                      final isLast = memo == memos.last;

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
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await onTapMemoListItem(memo);
                                },
                                child: Text(memo.title),
                              ),
                            ),
                            Container(
                              width: 0.3,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            if (memo.historyId == null)
                              IconButton(
                                onPressed: () {
                                  onTapCreateHistory(memo);
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                ),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  onTapViewHistory(memo);
                                },
                                icon: Icon(
                                  Icons.layers,
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
