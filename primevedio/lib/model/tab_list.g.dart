part of 'package:primevedio/model/tab_list.dart';

MenuInfo _$MenuInfoFromJson(Map<String, dynamic> json) {
  return MenuInfo(
    json['id'] as int,
    json['resourceName'] as String,
    json['relationType'] as String,
    json['linkUrl'] as String,
    json['type'] as int,
    json['enabled'] as bool,
    json['childrenType'] as int,
    json['icon'] as String,
    json['subTitle'] as String,
    json['order_no'] as int,
  );
}

Map<String, dynamic> _$MenuInfoToJson(MenuInfo instance) => <String, dynamic>{
      'id': instance.id,
      'resourceName': instance.resourceName,
      'relationType': instance.relationType,
      'linkUrl': instance.linkUrl,
      'icon': instance.icon,
      'subTitle': instance.subTitle,
      'type': instance.type,
      'enabled': instance.enabled,
      'childrenType': instance.childrenType,
      'order_no': instance.orderNo,
    };
