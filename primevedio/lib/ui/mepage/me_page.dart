import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/utils/ui_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: UIData.spaceSizeHeight210,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith10),
          child: Column(
            children: [
              Container(
                height: UIData.spaceSizeHeight210,
                color: Colors.green,
              ),
              SizedBox(
                height: UIData.spaceSizeHeight22,
              ),
              Container(
                height: UIData.spaceSizeHeight75,
                color: Colors.green,
              ),
              SizedBox(
                height: UIData.spaceSizeHeight22,
              ),
              Container(
                height: UIData.spaceSizeHeight75,
                color: Colors.green,
              )
            ],
          ),
        )
      ],
    );
  }

  // Widget headerWidget() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           width: 84,
  //           height: 84,
  //           decoration: BoxDecoration(
  //               border: Border.all(
  //                   color: UIData.primaryColor, width: UIData.spaceSizeWith4),
  //               borderRadius: BorderRadius.circular(42)),
  //           child: ClipOval(
  //             child: Image.network(
  //               'https://img.ixintu.com/download/jpg/201910/fc0f312a8d6095f51e68e19cf8ab0716.jpg!con',
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //         )
  //       ]);
  // }

  Widget clipPathShape() {
    return ClipOval(
        // clipper: ShapeBorderClipper(
        //   shape: CircleBorder(
        //
        //     side: BorderSide(
        //         width: UIData.spaceSizeWith4, color: UIData.primaryColor),
        //   ),
        // ),
        child: Image.network(
      'https://img.ixintu.com/download/jpg/201910/fc0f312a8d6095f51e68e19cf8ab0716.jpg!con',
      // fit: BoxFit.fill,
      height: 80,
    ));
  }

  Widget _circleBorder1() {
    return Container(
      width: UIData.spaceSizeHeight92,
      height: UIData.spaceSizeWith92,
      // margin: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        // color: Colors.red,
        image: const DecorationImage(
          image: NetworkImage(
            'https://img.syt5.com/2020/0904/20200904085741407.jpg.1680.0.jpg',
          ),
          fit: BoxFit.cover,
        ),
        shape: CircleBorder(
          side: BorderSide(
              width: UIData.spaceSizeWith10, color: UIData.primaryColor),
        ),
      ),
    );
  }
}
