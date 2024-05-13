part of '../mind_content_screen.dart';

enum _MindContentScreenType {
  exercise,
  intro,
  explanation;

  const _MindContentScreenType();

  bool get isExercise => this == exercise;

  bool get isIntro => this == intro;
}