import 'package:json_annotation/json_annotation.dart';

part 'package:primevedio/model/tab_list.g.dart';

@JsonSerializable()
class MenuInfo extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'resourceName')
  String resourceName;

  @JsonKey(name: 'relationType')
  String relationType;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'subTitle')
  String subTitle;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'childrenType')
  int childrenType;

  @JsonKey(name: 'order_no')
  int orderNo;

  MenuInfo(
      this.id,
      this.resourceName,
      this.relationType,
      this.linkUrl,
      this.type,
      this.enabled,
      this.childrenType,
      this.icon,
      this.subTitle,
      this.orderNo);

  factory MenuInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$MenuInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MenuInfoToJson(this);
}

class MemberInfoItem extends Object {
  String title;
  String img;
  MemberInfoItem(this.title, this.img);
}
