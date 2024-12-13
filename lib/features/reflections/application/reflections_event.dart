part of 'reflections_bloc.dart';

@freezed
class ReflectionsEvent with _$ReflectionsEvent {
  const factory ReflectionsEvent.getReflections() = GetReflections;

  const factory ReflectionsEvent.setActiveReflection({required Reflection reflection}) =
      SetActiveReflection;

  const factory ReflectionsEvent.resetActiveReflection() = ResetActiveReflection;

  const factory ReflectionsEvent.saveReflectionAnswer({required SubmitReflectionBody data}) =
      SaveReflectionAnswer;

  const factory ReflectionsEvent.updateReflectionAnswer({required SubmitReflectionBody data}) =
      UpdateReflectionAnswer;
}
