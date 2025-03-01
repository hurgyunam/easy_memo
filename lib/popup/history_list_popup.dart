import 'package:easy_memo/data/memo.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../element/normal_button.dart';
import 'create_history_memo_popup.dart';
import 'edit_popup.dart';

class HistoryListPopup extends ConsumerStatefulWidget {
  final String historyId;

  const HistoryListPopup({
    super.key,
    required this.historyId,
  });

  @override
  ConsumerState<HistoryListPopup> createState() => _HistoryListPopupState();
}

class _HistoryListPopupState extends ConsumerState<HistoryListPopup> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  List<Memo> historyMemos = [];

  @override
  void initState() {
    super.initState();

    loadHistoryMemos();
  }

  Future<void> loadHistoryMemos() async {
    final memoStorage = ref.read(memoStorageProvider);

    final memos =
        await memoStorage.loadByHistoryId(historyId: widget.historyId);

    setState(() {
      historyMemos = memos;
    });
  }

  Future<void> onTapMemoListItem(Memo memo) async {
    final savedMemoId =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditPopup(
        memoId: memo.memoId,
        title: memo.title,
        content: memo.text,
        date: memo.date,
      );
    }));

    if (savedMemoId != null) {
      loadHistoryMemos();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모가 수정되었습니다.")));
    }
  }

  Future<void> onTapAddMemo() async {
    final savedMemoId =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateHistoryMemoPopup(
        historyId: widget.historyId,
        rootMemoTitle: historyMemos.last.title,
      );
    }));

    if (savedMemoId != null) {
      loadHistoryMemos();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("메모가 추가되었습니다.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memo History Group"),
      ),
      body: SafeArea(
        child: RawScrollbar(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        ...historyMemos.map((memo) {
                          final isLast = memo == historyMemos.last;

                          return Container(
                            // list item
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: isLast
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 0.3,
                                      ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      onTapMemoListItem(memo);
                                    },
                                    child: Text(memo.title),
                                  ),
                                ),
                                Text(
                                  dateFormat.format(memo.date),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  NormalButton(
                    text: "해당 히스토리에 신규 메모 추가",
                    onTap: () async {
                      onTapAddMemo();
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
