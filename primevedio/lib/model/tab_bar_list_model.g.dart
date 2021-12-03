// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_bar_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabBarListModel _$TabBarListModelFromJson(Map<String, dynamic> json) =>
    TabBarListModel(
      (json['list'] as List<dynamic>)
          .map((e) => TabBarType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TabBarListModelToJson(TabBarListModel instance) =>
    <String, dynamic>{
      'list': instance.typeBarList,
    };

TabBarType _$TabBarTypeFromJson(Map<String, dynamic> json) => TabBarType(
      json['list_id'] as int,
      json['list_name'] as String,
    );

Map<String, dynamic> _$TabBarTypeToJson(TabBarType instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
    };
