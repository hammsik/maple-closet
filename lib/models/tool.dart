import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool.freezed.dart';

enum ToolType {
  beauty,
  armor,
  accessory,
  color,
  unknown,
  favorite,
}

enum SubCategoryType {
  hair,
  face,
  head,
  hat,
  overall,
  cash,
  top,
  bottom,
  cape,
  glove,
  shoes,
  shield,
  faceAccessory,
  eyeDecoration,
  earrings,
}

@freezed
class SubCategory with _$SubCategory {
  const factory SubCategory({
    required String nameKo,
    required String nameEn,
    required SubCategoryType type,
  }) = _SubCategory;
}

@freezed
class MyTool with _$MyTool {
  const factory MyTool({
    required String toolNameKo,
    required ToolType toolType,
    SubCategoryType? currentSubcategoryType,
    Map<SubCategoryType, SubCategory>? subCategoryMap,
  }) = _MyTool;
}
