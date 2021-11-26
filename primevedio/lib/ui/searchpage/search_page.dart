import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String searchValue = '';
  final List<String> contents = [];
  late List<String> hisArray = [
    'testttttttttt',
    '11112222222',
    'test',
    'winddd'
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
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
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchResultPage(
                  keys: value,
                );
              }));
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
        children: List.generate(hisArray.length, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                searchValue = hisArray[index];
              });
              _controller.text = searchValue;
            },
            child: Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(2)),
              ),
              backgroundColor: Colors.white,
              label: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight11),
                child: CommonText.dialogText(
                  hisArray[index],
                ),
              ),
            ),
          );
        }),
      ),
    );
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
                    onPressed: () {
                      setState(() {
                        hisArray = [];
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}
