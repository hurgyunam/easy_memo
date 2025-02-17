import 'package:easy_memo/element/memo_editor_frame.dart';
import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageAddMemo extends ConsumerStatefulWidget {
  const PageAddMemo({super.key});

  @override
  ConsumerState<PageAddMemo> createState() => _PageAddMemoState();
}

class _PageAddMemoState extends ConsumerState<PageAddMemo> {
  DateTime nowZeroTime = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );
  String textTitle = "";
  String textContent = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> _onClickAddButton() async {
    final memoStorage = ref.read(memoStorageProvider);

    await memoStorage.saveMemo(
      date: nowZeroTime,
      title: textTitle,
      content: textContent,
    );

    titleController.text = "";
    contentController.text = "";
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("메모가 추가되었습니다.")));
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          // 페이지 outside
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MemoEditorFrame(
                titleEditor: TextField(
                  decoration: InputDecoration(hintText: "제목"),
                  controller: titleController,
                  onChanged: (title) {
                    setState(() {
                      textTitle = title;
                    });
                  },
                ),
                contentEditor: TextField(
                  minLines: 6,
                  maxLines: null,
                  controller: contentController,
                  onChanged: (content) {
                    setState(() {
                      textContent = content;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "메모 작성 중..",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                selectedDate: nowZeroTime,
              ),
              SizedBox(height: 20),
              NormalButton(
                text: "저장",
                onTap: () async {
                  _onClickAddButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
