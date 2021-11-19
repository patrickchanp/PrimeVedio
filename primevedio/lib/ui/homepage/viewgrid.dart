import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class ViewGrid extends StatefulWidget {
  const ViewGrid({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewGridState();
}

class _ViewGridState extends State<ViewGrid> {
  var imgList = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2877516247,37083492&fm=26&gp=0.jpg',
    'https://pica.zhimg.com/v2-3b4fc7e3a1195a081d0259246c38debc_720w.jpg?source=172ae18b'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, int index) => _buildGridItem(index),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.78,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        maxCrossAxisExtent: 159,
      ),
    );
  }

  _buildGridItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(11.65)),
            image: DecorationImage(
                image: NetworkImage(imgList[index % 2]), fit: BoxFit.fill),
          ),
          height: UIData.spaceSizeHeight202,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 12.0),
          child: CommonText.normalText("text"),
        )
      ],
    );
  }
}
