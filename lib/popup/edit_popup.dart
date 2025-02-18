import 'package:easy_memo/element/memo_editor_frame.dart';
import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPopup extends ConsumerStatefulWidget {
  final String memoId;
  final String title, content;
  final DateTime date;
  const EditPopup({
    super.key,
    required this.memoId,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  ConsumerState<EditPopup> createState() => _EditPopupState();
}

class _EditPopupState extends ConsumerState<EditPopup> {
  String textTitle = "";
  String textContent = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    contentController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Memo"),
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
                    selectedDate: widget.date,
                  ),
                  SizedBox(height: 20),
                  NormalButton(
                    text: "수정",
                    onTap: () async {
                      final memoStorage = ref.read(memoStorageProvider);

                      final savedMemoId = memoStorage.saveMemo(
                        title: textTitle,
                        content: textContent,
                        date: widget.date,
                        memoId: widget.memoId,
                      );

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
