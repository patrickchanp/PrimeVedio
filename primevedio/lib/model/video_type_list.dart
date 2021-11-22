import 'package:json_annotation/json_annotation.dart';

part 'video_type_list.g.dart';

@JsonSerializable()
class TabBarListModel extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'pagecount')
  int pagecount;

  @JsonKey(name: 'limit')
  String limit;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'class')
  List<TabBarType> tabBarList;

  TabBarListModel(
    this.code,
    this.msg,
    this.page,
    this.pagecount,
    this.limit,
    this.total,
    this.tabBarList,
  );

  factory TabBarListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TabBarListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabBarListModelToJson(this);
}

@JsonSerializable()
class TabBarType extends Object {
  @JsonKey(name: 'type_id')
  int typeId;

  @JsonKey(name: 'type_name')
  String typeName;

  TabBarType(
    this.typeId,
    this.typeName,
  );

  factory TabBarType.fromJson(Map<String, dynamic> srcJson) =>
      _$TabBarTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabBarTypeToJson(this);
}
