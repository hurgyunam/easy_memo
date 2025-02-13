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

                  final allMap = await memoStorage.readAll();

                  print(savedId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
