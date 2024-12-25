import 'dart:developer';

import 'package:easy_memo/data/ui/memo_line.dart';
import 'package:easy_memo/provider/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditorPage extends ConsumerStatefulWidget {
  const EditorPage({super.key});

  @override
  ConsumerState<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends ConsumerState<EditorPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<MemoLine> memoLines = [];
  String textValue = "";
  int tab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onSubmitted(String value) {
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

    ref.read(storageProvider).writeMemo(memoLines);
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
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
