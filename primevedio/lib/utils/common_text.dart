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
          fontSize: UIData.fontSize2541,
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
          fontSize: UIData.fontSize1906,
          fontWeight: FontWeight.normal,
          color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
