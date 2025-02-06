import 'package:easy_memo/page/add_memo.dart';
import 'package:flutter/material.dart';

class ScaffoldMain extends StatefulWidget {
  const ScaffoldMain({super.key});

  @override
  State<ScaffoldMain> createState() => _ScaffoldMainState();
}

class _ScaffoldMainState extends State<ScaffoldMain> {
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
                child: PageAddMemo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
