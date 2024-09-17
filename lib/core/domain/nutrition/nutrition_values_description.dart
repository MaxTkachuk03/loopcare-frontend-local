import 'package:loopcare_frontend/core/domain/nutrition/nutrition_description_item.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const calorieDensityDataItems = [
  {
    "minValue": 0,
    "maxValue": 1.64,
    "description": LocalizedTexts.calorieDensityHighQualityDescription,
    "label": LocalizedTexts.calorieDensityHighQualityLabel,
  },
  {
    "minValue": 1.65,
    "maxValue": 1.89,
    "description": LocalizedTexts.calorieDensityMidQualityDescription,
    "label": LocalizedTexts.calorieDensityMidQualityLabel,
  },
  {
    "minValue": 1.9,
    "maxValue": 66.6,
    "description": LocalizedTexts.calorieDensityLowQualityDescription,
    "label": LocalizedTexts.calorieDensityLowQualityLabel,
  },
];

const proteinDegreeDataItems = [
  {
    "minValue": 0,
    "maxValue": 15,
    "description": LocalizedTexts.proteinDegreeLowQualityDescription,
    "label": LocalizedTexts.proteinDegreeLowQualityLabel,
  },
  {
    "minValue": 15,
    "maxValue": 19.99,
    "description": LocalizedTexts.proteinDegreeLowMidQualityDescription,
    "label": LocalizedTexts.proteinDegreeLowMidQualityLabel,
  },
  {
    "minValue": 20,
    "maxValue": 25,
    "description": LocalizedTexts.proteinDegreeMidQualityDescription,
    "label": LocalizedTexts.proteinDegreeMidQualityLabel,
  },
  {
    "minValue": 25,
    "maxValue": 100,
    "description": LocalizedTexts.proteinDegreeHighQualityDescription,
    "label": LocalizedTexts.proteinDegreeHighQualityLabel,
  },
];

const fiberDataItems = [
  {
    "minValue": 1,
    "maxValue": 12.99,
    "description": "",
    "label": LocalizedTexts.fiberHighQualityLabel,
  },
  {
    "minValue": 13,
    "maxValue": 24.99,
    "description": "",
    "label": LocalizedTexts.fiberMidQualityLabel,
  },
  {
    "minValue": 25,
    "maxValue": 100,
    "description": "",
    "label": LocalizedTexts.fiberLowQualityLabel,
  },
];

class NutritionValuesDescription {
  NutritionValuesDescription._();

  static final List<NutritionValueDescriptionItem> calorieDensityItems =
      calorieDensityDataItems.map((e) => NutritionValueDescriptionItem.fromJson(e)).toList();

  static final List<NutritionValueDescriptionItem> proteinDegreeItems =
      proteinDegreeDataItems.map((e) => NutritionValueDescriptionItem.fromJson(e)).toList();

  static final List<NutritionValueDescriptionItem> fiberItems =
      fiberDataItems.map((e) => NutritionValueDescriptionItem.fromJson(e)).toList();

  static NutritionValueDescriptionItem getCalorieDensityItemByValue(double value) {
    if (value < calorieDensityItems.first.minValue) {
      return calorieDensityItems.first;
    }
    if (value > calorieDensityItems.last.maxValue) {
      return calorieDensityItems.last;
    }

    return calorieDensityItems.firstWhere((e) => e.minValue <= value && value <= e.maxValue);
  }

  static NutritionValueDescriptionItem getProteinDegreeItemByValue(double value) {
    if (value < proteinDegreeItems.first.minValue) {
      return proteinDegreeItems.first;
    }
    if (value > proteinDegreeItems.last.maxValue) {
      return proteinDegreeItems.last;
    }

    return proteinDegreeItems.firstWhere((e) => e.minValue <= value && value <= e.maxValue);
  }

  static NutritionValueDescriptionItem getFiberItemByValue(double value) {
    if (value < fiberItems.first.minValue) return fiberItems.first;
    if (value > fiberItems.last.maxValue) return fiberItems.last;

    return fiberItems.firstWhere((e) => e.minValue <= value && value <= e.maxValue);
  }
}
