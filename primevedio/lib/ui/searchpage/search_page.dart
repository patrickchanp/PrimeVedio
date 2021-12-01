import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/sqflite/helper.dart';
import 'package:primevedio/sqflite/search_history.dart';
import 'package:primevedio/ui/searchpage/search_result_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String searchValue;
  final TextEditingController _controller = TextEditingController();
  List<SearchValue> searchValues = [];

  void getDatabase() {
    DBHelper().getSearchValues().then((value) {
      setState(() {
        searchValues = value;
      });
    });
  }

  @override
  void initState() {
    getDatabase();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.primaryColor,
      body: _buildSearchPage(),
    );
  }

  Widget _buildSearchPage() {
    return Padding(
      padding: EdgeInsets.only(
          top: UIData.spaceSizeHeight65,
          right: UIData.spaceSizeWith26,
          left: UIData.spaceSizeWith26),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                suffixIcon: _controller.text.trim().isNotEmpty
                    ? GestureDetector(
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onTap: () {
                          setState(() {
                            _controller.text = '';
                          });
                        })
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(5))),
                hintText: '  请输入关键字搜索',
                hintStyle: TextStyle(
                  color: UIData.hintColor,
                  fontSize: UIData.fontSize20,
                )),
            style: TextStyle(fontSize: UIData.fontSize20, color: Colors.black),
            onChanged: (value) {
              setState(() {
                searchValue = value;
              });
            },
            onSubmitted: (value) {
              value.trim() != ''
                  ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return SearchResultPage(
                        keys: value,
                      );
                    }))
                  : '';
              value.trim() != '' ? _insertData() : '';
              _controller.text = '';
            },
            controller: _controller,
          ),
          SizedBox(
            height: UIData.spaceSizeHeight30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText.normalText('历史搜索'),
              GestureDetector(
                child: const Icon(
                  MyIcons.clearIcon,
                  color: Colors.white,
                ),
                onTap: showClearDialog,
              )
            ],
          ),
          SizedBox(
            height: UIData.spaceSizeHeight18,
          ),
          _getHistoryWidget(),
        ],
      ),
    );
  }

  Widget _getHistoryWidget() {
    return SizedBox(
        width: double.infinity, //百分百相对
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: UIData.spaceSizeWith10,
          runSpacing: UIData.spaceSizeHeight11,
          children: List.generate(searchValues.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  searchValue = searchValues[index].searchWord;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchResultPage(
                    keys: searchValue,
                  );
                }));
              },
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(2)),
                ),
                backgroundColor: Colors.white,
                label: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight11),
                  child: CommonText.dialogText(searchValues[index].searchWord),
                ),
              ),
            );
          }),
        ));
  }

  showClearDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CommonText.dialogText("提示"),
            content: CommonText.dialogText("确定清空？"),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: CommonText.dialogText("取消"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: CommonText.dialogText("确定"),
                    onPressed: () async {
                      DBHelper().deleteSearchValue();
                      getDatabase();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  void _insertData() async {
    var searchWord = SearchValue(searchValue);
    var dbHelper = DBHelper();
    dbHelper.saveSearchValue(searchWord);
    getDatabase();
  }
}
