import 'package:easy_memo/element/memo_editor_frame.dart';
import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateHistoryMemoPopup extends ConsumerStatefulWidget {
  final String? rootMemoId;
  final String? historyId;
  final String rootMemoTitle;
  const CreateHistoryMemoPopup({
    super.key,
    this.rootMemoId,
    this.historyId,
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
  String? beforeMemoContent;

  DateTime nowZeroTime = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  @override
  void initState() {
    super.initState();

    initBeforeMemoContent();
  }

  Future<void> initBeforeMemoContent() async {
    final rootMemoId = widget.rootMemoId;
    final historyId = widget.historyId;

    if (rootMemoId != null) {
      final memoStorage = ref.read(memoStorageProvider);
      final lastMemo = await memoStorage.loadByMemoId(memoId: rootMemoId);

      if (lastMemo != null) {
        setState(() {
          beforeMemoContent = lastMemo.text;
          contentController.text = lastMemo.text;
        });
      } else {
        throw Exception("root memo의 content text를 불러오는데 실패했습니다.");
      }
    } else if (historyId != null) {
      final memoStorage = ref.read(memoStorageProvider);
      final memos = await memoStorage.loadByHistoryId(historyId: historyId);

      setState(() {
        beforeMemoContent = memos.last.text;
        contentController.text = memos.last.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final beforeMemoContent = this.beforeMemoContent;

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
                        rootMemoId: widget.rootMemoId,
                        historyId: widget.historyId,
                      );

                      Navigator.pop(context, savedMemoId);
                    },
                  ),
                  SizedBox(height: 20),
                  if (beforeMemoContent != null)
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text("이전 메모와의 비교"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(beforeMemoContent),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
