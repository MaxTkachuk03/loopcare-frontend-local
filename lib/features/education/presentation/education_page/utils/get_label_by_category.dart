import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';

Widget getLabelByCategory(String category) {
  switch (category) {
    case 'general':
      return CategoryLabel.general();
    case 'nutrition':
      return CategoryLabel.nutrition();
    case 'mind':
      return CategoryLabel.mind();
    case 'activity':
      return CategoryLabel.activity();
    case 'buddy':
      return CategoryLabel.buddy();
  }

  return CategoryLabel.general();
}
