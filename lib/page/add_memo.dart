import 'package:easy_memo/element/normal_button.dart';
import 'package:easy_memo/provider/memo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PageAddMemo extends ConsumerStatefulWidget {
  const PageAddMemo({super.key});

  @override
  ConsumerState<PageAddMemo> createState() => _PageAddMemoState();
}

class _PageAddMemoState extends ConsumerState<PageAddMemo> {
  final DateFormat format = DateFormat("yyyy-MM-dd");
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(5),
                ),
                // Date, Title, Content
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 11,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Date
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          Text(
                            format.format(nowZeroTime),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      height: 1,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Date
                        children: [
                          Text(
                            "Title",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              decoration: InputDecoration(hintText: "제목"),
                              controller: titleController,
                              onChanged: (title) {
                                setState(() {
                                  textTitle = title;
                                });
                              },
                            ),
                          ),
                          // Text(
                          //   "제목",
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .labelMedium
                          //       ?.copyWith(
                          //         color: Theme.of(context).colorScheme.tertiary,
                          //       ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0x34545456)),
                      ),
                      height: 1,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      child: TextField(
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
                    ),
                  ],
                ),
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
