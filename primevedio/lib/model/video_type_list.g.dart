// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_type_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabBarListModel _$TabBarListModelFromJson(Map<String, dynamic> json) =>
    TabBarListModel(
      json['code'] as int,
      json['msg'] as String,
      json['page'] as int,
      json['pagecount'] as int,
      json['limit'] as String,
      json['total'] as int,
      (json['class'] as List<dynamic>)
          .map((e) => TabBarType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TabBarListModelToJson(TabBarListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'page': instance.page,
      'pagecount': instance.pagecount,
      'limit': instance.limit,
      'total': instance.total,
      'class': instance.tabBarList,
    };

TabBarType _$TabBarTypeFromJson(Map<String, dynamic> json) => TabBarType(
      json['type_id'] as int,
      json['type_name'] as String,
    );

Map<String, dynamic> _$TabBarTypeToJson(TabBarType instance) =>
    <String, dynamic>{
      'type_id': instance.typeId,
      'type_name': instance.typeName,
    };
