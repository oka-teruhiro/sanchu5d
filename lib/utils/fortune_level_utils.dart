// lib/utils/fortune_level_utils.dart
class FortuneLevelUtils {
  static String getFortuneLevelText(int level) {
    switch (level) {
      case 7:
        return '大吉';
      case 6:
        return '中吉';
      case 5:
        return '小吉';
      case 4:
        return '平';
      case 3:
        return '小凶';
      case 2:
        return '中凶';
      case 1:
        return '大凶';
      default:
        return '平';
    }
  }
}