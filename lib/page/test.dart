import 'package:easy_memo/data/memo.dart';
import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageTest extends ConsumerWidget {
  const PageTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoStorage = ref.watch(memoStorageProvider);

    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              NormalButton(
                text: "테스트 1: 메모 Date List가 저장되지 않음",
                onTap: () async {
                  final savedId = await memoStorage.saveMemo(
                      date: DateTime.now(), title: "TITLE", content: "CONTENT");

                  final List<Memo> memos =
                      await memoStorage.loadByDate(date: DateTime.now());

                  print(memos);
                },
              ),
              SizedBox(height: 10),
              NormalButton(
                text: "테스트 2: 처음 history가 만들어질 때",
                onTap: () async {
                  final oldMemoId = await memoStorage.saveMemo(
                      date: DateTime.now(), title: "TITLE", content: "CONTENT");
                  final newMemoId = await memoStorage.saveMemo(
                      date: DateTime.now(),
                      title: "TITLE",
                      content: "CONTENT",
                      rootMemoId: oldMemoId);

                  final all = await memoStorage.readAll();

                  print(all);
                },
              ),
              SizedBox(height: 10),
              NormalButton(
                text: "테스트 3: 날짜에 따른 메모 검색",
                onTap: () async {
                  final memoId = await memoStorage.saveMemo(
                      date: DateTime.now(),
                      title: "DATE SEARCH",
                      content: "DATE SEARCH CONTENT");

                  List<Memo> memos =
                      await memoStorage.loadByDate(date: DateTime.now());

                  final filtered =
                      memos.where((memo) => memo.memoId == memoId).toList();

                  if (filtered.length == 1) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("성공")));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("실패")));
                  }
                },
              ),
              SizedBox(height: 10),
              NormalButton(
                text: "테스트 4: 히스토리 ID로 메모 탐색",
                onTap: () async {
                  final oldMemoId = await memoStorage.saveMemo(
                      date: DateTime.now(), title: "TITLE", content: "CONTENT");
                  final newMemoId = await memoStorage.saveMemo(
                      date: DateTime.now(),
                      title: "TITLE",
                      content: "CONTENT",
                      rootMemoId: oldMemoId);
                  if (newMemoId != null) {
                    final memo =
                        await memoStorage.loadByMemoId(memoId: newMemoId);

                    if (memo != null) {
                      final historyId = memo.historyId;

                      if (historyId != null) {
                        final memos = await memoStorage.loadByHistoryId(
                            historyId: historyId);

                        if (memos.length == 2) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("성공")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("실패: 메모 길이 ${memos.length}")));
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("실패: 저장된 메모 불러오지 못함")));
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("메모 로드 실패")));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
