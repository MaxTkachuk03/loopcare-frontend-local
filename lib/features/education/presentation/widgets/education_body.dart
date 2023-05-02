import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/domain/education_card_type.dart';
import 'package:loopcare_frontend/features/education/domain/education_item.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_card.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/progress_item.dart';

List<EducationItem> _cardList = const [
  EducationItem(
      title: 'Setting expectations for a healthier lifestyle',
      label: 'General',
      duration: '3m 59s',
      type: EducationCardType.passed),
  EducationItem(
      title: 'Understanding weight loss',
      label: 'General',
      duration: '3m 59s',
      type: EducationCardType.passed),
  EducationItem(
      title: 'The Yo-yo effect',
      label: 'Assignment',
      duration: '3m 59s',
      type: EducationCardType.available),
  EducationItem(
      title: 'Write down your 3 reasons to loose weight',
      label: 'Mind',
      duration: '3m 59s',
      type: EducationCardType.available),
  EducationItem(
      title: 'The importance of the buddy system',
      label: 'General',
      duration: '3m 59s',
      type: EducationCardType.blocked),
  EducationItem(
      title: 'Getting realistic weight loss expectations',
      label: 'General',
      duration: '3m 59s',
      type: EducationCardType.blocked),
  EducationItem(
      title: 'Expecting and defeating stalls in weight loss',
      label: 'General',
      duration: '3m 59s',
      type: EducationCardType.blocked),
];

class EducationBody extends StatelessWidget {
  const EducationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.orange,
          height: 40,
        ),
        MainContainer(
          child: ListView.builder(
            itemCount: _cardList.length,
            itemBuilder: (BuildContext context, index) {
              final isLastElement = index + 1 == _cardList.length;
              final isFirstElement = index == 0;

              return IntrinsicHeight(
                child: Row(
                  children: [
                    ProgressItem(
                      isFirst: isFirstElement,
                      isLast: isLastElement,
                      type: _cardList[index].type,
                      nextItemType:
                          !isLastElement ? _cardList[index + 1].type : null,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          EducationCard(
                            item: _cardList[index],
                          ),
                          const SizedBox(
                            height: 12.0,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
