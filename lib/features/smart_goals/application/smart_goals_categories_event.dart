part of 'smart_goals_categories_bloc.dart';

@freezed
class SmartGoalsCategoriesEvent with _$SmartGoalsCategoriesEvent {
  const factory SmartGoalsCategoriesEvent.getCategories({required String stream}) = GetCategories;

  const factory SmartGoalsCategoriesEvent.unlockCategory({required int id}) = UnlockCategory;
}
