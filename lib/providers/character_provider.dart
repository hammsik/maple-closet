import 'dart:typed_data';

import 'package:maple_closet/data/color_palette.dart';
import 'package:maple_closet/mixins/character_method.dart';
import 'package:maple_closet/models/character_history.dart';
import 'package:maple_closet/models/equipment.dart';
import 'package:maple_closet/models/item.dart';
import 'package:maple_closet/models/tool.dart';
import 'package:maple_closet/providers/api_provider.dart';
import 'package:maple_closet/providers/setting_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_provider.g.dart';

@Riverpod(keepAlive: true)
class Character extends _$Character with CharacterMethod {
  @override
  History build() {
    // 초기 상태로 equipment가 하나 들어있는 History를 생성합니다.
    print('Character has been build');
    return const History(
      equipments: [
        Equipment(
          hairColor1: HairColor.black,
          hairColor2: HairColor.black,
          lensColor1: LensColor.black,
          lensColor2: LensColor.black,
          head: Item(
              id: '12016',
              name: '홍조 꽃잎 피부',
              subCategoryType: SubCategoryType.head),
          // body없는 이유는 head에서 substring(1)만 하면 되므로... 이거 toJson에도 반영을 해야함..
        ),
      ],
      maxHistoryLength: 10,
    );
  }

  Equipment getCurrentCharacter() {
    return state.equipments[state.historyIndex];
  }

  void updateEquipment({
    required Item item,
  }) {
    List<Equipment> renewedCharacterHistory = renewCharacterHistory();

    renewedCharacterHistory.add(
      generateNewEquipment(
        equipment: renewedCharacterHistory.last,
        subCategoryType: item.subCategoryType,
        item: item,
      ),
    );

    state = state.copyWith(
        equipments: renewedCharacterHistory,
        historyIndex: renewedCharacterHistory.length - 1);
  }

  void takeOffEquipment({
    required SubCategoryType subCategoryType,
  }) {
    List<Equipment> renewedCharacterHistory = renewCharacterHistory();

    renewedCharacterHistory.add(
      generateNewEquipment(
        equipment: renewedCharacterHistory.last,
        subCategoryType: subCategoryType,
        item: null,
      ),
    );

    state = state.copyWith(
        equipments: renewedCharacterHistory,
        historyIndex: renewedCharacterHistory.length - 1);
  }

  void updateHairColor({
    required HairColor hairColor1,
    required HairColor hairColor2,
  }) {
    List<Equipment> renewedCharacterHistory = renewCharacterHistory();

    renewedCharacterHistory.add(
      renewedCharacterHistory.last.copyWith(
        hairColor1: hairColor1,
        hairColor2: hairColor2,
      ),
    );

    state = state.copyWith(
        equipments: renewedCharacterHistory,
        historyIndex: renewedCharacterHistory.length - 1);
  }

  void updateLensColor({
    required LensColor lensColor1,
    required LensColor lensColor2,
  }) {
    List<Equipment> renewedCharacterHistory = renewCharacterHistory();

    renewedCharacterHistory.add(
      renewedCharacterHistory.last.copyWith(
        lensColor1: lensColor1,
        lensColor2: lensColor2,
      ),
    );

    state = state.copyWith(
        equipments: renewedCharacterHistory,
        historyIndex: renewedCharacterHistory.length - 1);
  }

  List<Equipment> renewCharacterHistory() {
    // 만약 현재 historyIndex가 마지막 index가 아니라면, 현재 index 이후의 항목을 제거합니다.
    if (state.historyIndex < state.equipments.length - 1) {
      return state.equipments.sublist(0, state.historyIndex + 1);
    }

    // 만약 max길이에 도달했을 때는 가장 오래된 항목만 제거합니다.
    if (state.equipments.length == state.maxHistoryLength) {
      return state.equipments.sublist(1);
    }

    return [...state.equipments];
  }

  void undo() {
    // 코디를 이전 상태로 되돌립니다.
    if (state.historyIndex > 0) {
      state = state.copyWith(historyIndex: state.historyIndex - 1);
    }
  }

  void redo() {
    // 코디를 다음 상태로 되돌립니다.
    if (state.historyIndex < state.equipments.length - 1) {
      state = state.copyWith(historyIndex: state.historyIndex + 1);
    }
  }

  Future<List<Uint8List>> getCurrentCharacterImageByUint() {
    List<String> itemsBodyList =
        state.equipments[state.historyIndex].makeCharacterItemsBodyPair();

    List<String> standUrls = [
      'https://maplestory.io/api/Character/${itemsBodyList[0]}/stand1/0?bgColor=230,222,218,255',
      'https://maplestory.io/api/Character/${itemsBodyList[1]}/stand1/0?bgColor=230,222,218,255',
    ];
    List<String> standGifUrls = [
      'https://maplestory.io/api/Character/${itemsBodyList[0]}/stand1/animated?bgColor=230,222,218,255',
      'https://maplestory.io/api/Character/${itemsBodyList[1]}/stand1/animated?bgColor=230,222,218,255',
    ];
    List<String> walkGifUrls = [
      'https://maplestory.io/api/Character/${itemsBodyList[0]}/walk1/animated?bgColor=230,222,218,255',
      'https://maplestory.io/api/Character/${itemsBodyList[1]}/walk1/animated?bgColor=230,222,218,255',
    ];

    switch (ref.read(imageSettingProvider)) {
      case ImageType.stand:
        return ref.read(apiProvider.notifier).getCharacterImage(standUrls);
      case ImageType.standGif:
        return ref.read(apiProvider.notifier).getCharacterImage(standGifUrls);
      case ImageType.walkGif:
        return ref.read(apiProvider.notifier).getCharacterImage(walkGifUrls);
    }
  }

  Item? getCurrentItemBySubCategory({required SubCategoryType type}) {
    Equipment currentCharacter = getCurrentCharacter();
    switch (type) {
      case SubCategoryType.hair:
        return currentCharacter.hair;
      case SubCategoryType.face:
        return currentCharacter.face;
      case SubCategoryType.head:
        return currentCharacter.head;
      case SubCategoryType.hat:
        return currentCharacter.hat;
      case SubCategoryType.overall:
        return currentCharacter.overAll;
      case SubCategoryType.cash:
        return currentCharacter.cash;
      case SubCategoryType.top:
        return currentCharacter.top;
      case SubCategoryType.bottom:
        return currentCharacter.bottom;
      case SubCategoryType.cape:
        return currentCharacter.cape;
      case SubCategoryType.glove:
        return currentCharacter.glove;
      case SubCategoryType.shoes:
        return currentCharacter.shoes;
      case SubCategoryType.shield:
        return currentCharacter.shield;
      case SubCategoryType.faceAccessory:
        return currentCharacter.faceAccessory;
      case SubCategoryType.eyeDecoration:
        return currentCharacter.eyeDecoration;
      case SubCategoryType.earrings:
        return currentCharacter.earrings;
    }
  }

  // List<String> getCurrentCharacterImageUrl() {
  //   // 현재 코디의 이미지 URL 2개를 반환합니다.
  //   List<String> itemsBodyList =
  //       getCurrentCharacter().makeCharacterItemsBodyPair();

  //   switch (ref.read(imageSettingProvider)) {
  //     case ImageType.stand:
  //       return [
  //         'https://maplestory.io/api/Character/${itemsBodyList[0]}/stand1/0?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[1]}/stand1/0?bgColor=230,222,218,255',
  //       ];
  //     case ImageType.standGif:
  //       return [
  //         'https://maplestory.io/api/Character/${itemsBodyList[0]}/stand1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[1]}/stand1/animated?bgColor=230,222,218,255',
  //       ];
  //     case ImageType.walkGif:
  //       return [
  //         'https://maplestory.io/api/Character/${itemsBodyList[0]}/walk1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[1]}/walk1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[0]}/walk1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[1]}/walk1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[0]}/walk1/animated?bgColor=230,222,218,255',
  //         'https://maplestory.io/api/Character/${itemsBodyList[1]}/walk1/animated?bgColor=230,222,218,255',
  //       ];
  //   }
  // }
}