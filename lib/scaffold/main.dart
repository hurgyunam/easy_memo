import 'package:easy_memo/page/add_memo.dart';
import 'package:easy_memo/page/calendar.dart';
import 'package:flutter/material.dart';

class ScaffoldMain extends StatefulWidget {
  const ScaffoldMain({super.key});

  @override
  State<ScaffoldMain> createState() => _ScaffoldMainState();
}

class _ScaffoldMainState extends State<ScaffoldMain> {
  final PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Simple Memo",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {},
                  children: [
                    PageAddMemo(),
                    PageCalendar(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: "메모작성",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "캘린더",
          ),
        ],
      ),
    );
  }
}
