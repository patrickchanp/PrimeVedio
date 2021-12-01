import 'package:flutter/material.dart';
import 'package:primevedio/utils/ui_data.dart';

class CommonText {
  //主标题
  static Widget mainTitle(text,
      {textAlign = TextAlign.left,
      overflow = TextOverflow.ellipsis,
      color = UIData.mainTitleColor}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: UIData.fontSize26,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //普通文本
  static Widget normalText(text,
      {textAlign = TextAlign.left,
      overflow = TextOverflow.ellipsis,
      color = UIData.mainTitleColor}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: UIData.fontSize20,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //标题文本
  static Widget titleText(text,
      {textAlign = TextAlign.left,
      overflow = TextOverflow.ellipsis,
      color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: UIData.fontSize16,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //提示框文本
  static Widget dialogText(text,
      {textAlign = TextAlign.center,
      overflow = TextOverflow.ellipsis,
      color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: UIData.fontSize20,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //我的文本
  static Widget mePageText(text,
      {textAlign = TextAlign.left,
      overflow = TextOverflow.ellipsis,
      color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: UIData.fontSize18,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
