import 'package:easy_memo/page/calendar_page.dart';
import 'package:easy_memo/page/category_page.dart';
import 'package:easy_memo/page/editor_page.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("EASY MEMO"),
      ),
      body: PageView(
        controller: pageController,
        children: [
          EditorPage(),
          CalendarPage(),
          CategoryPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: "Edit"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "category"),
        ],
      ),
    );
  }
}
