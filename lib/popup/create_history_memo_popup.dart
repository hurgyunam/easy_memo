import 'package:easy_memo/element/memo_editor_frame.dart';
import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateHistoryMemoPopup extends ConsumerStatefulWidget {
  final String rootMemoId;
  final String rootMemoTitle;
  const CreateHistoryMemoPopup({
    super.key,
    required this.rootMemoId,
    required this.rootMemoTitle,
  });

  @override
  ConsumerState<CreateHistoryMemoPopup> createState() =>
      _CreateHistoryMemoPopupState();
}

class _CreateHistoryMemoPopupState
    extends ConsumerState<CreateHistoryMemoPopup> {
  String textTitle = "";
  String textContent = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  DateTime nowZeroTime = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create History Memo From ${widget.rootMemoTitle}"),
      ),
      body: SafeArea(
        child: RawScrollbar(
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
                      decoration: const InputDecoration(
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
                    text: "메모를 히스토리에 추가",
                    onTap: () async {
                      final memoStorage = ref.read(memoStorageProvider);

                      final savedMemoId = memoStorage.saveMemo(
                          title: textTitle,
                          content: textContent,
                          date: nowZeroTime,
                          rootMemoId: widget.rootMemoId);

                      Navigator.pop(context, savedMemoId);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
