import 'dart:developer';

import 'package:easy_memo/data/ui/memo_line.dart';
import 'package:flutter/material.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<MemoLine> memoLines = [];
  String textValue = "";
  int tab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...memoLines.map((memoLine) {
            return Padding(
              padding: EdgeInsets.only(left: memoLine.tab * 10.0),
              child: Text(memoLine.value),
            );
          }),
          Padding(
            padding: EdgeInsets.only(left: tab * 10.0),
            child: TextField(
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
                log("onChanged $value");
              },
              onSubmitted: (value) {
                log("onSubmitted $value");
                if (value == "..t") {
                  setState(() {
                    tab++;
                  });
                } else if (value == "..r") {
                  setState(() {
                    tab--;
                  });
                } else {
                  setState(() {
                    memoLines.add(MemoLine(
                      tab: tab,
                      value: value,
                    ));
                  });
                }

                setState(() {
                  textEditingController.text = "";
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
