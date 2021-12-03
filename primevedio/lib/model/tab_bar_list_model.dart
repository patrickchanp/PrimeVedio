import 'package:json_annotation/json_annotation.dart';

part 'tab_bar_list_model.g.dart';

@JsonSerializable()
class TabBarListModel extends Object {
  @JsonKey(name: 'list')
  List<TabBarType> typeBarList;

  TabBarListModel(
    this.typeBarList,
  );

  factory TabBarListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TabBarListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabBarListModelToJson(this);
}

@JsonSerializable()
class TabBarType extends Object {
  @JsonKey(name: 'list_id')
  int listId;

  @JsonKey(name: 'list_name')
  String listName;

  TabBarType(
    this.listId,
    this.listName,
  );

  factory TabBarType.fromJson(Map<String, dynamic> srcJson) =>
      _$TabBarTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabBarTypeToJson(this);
}
