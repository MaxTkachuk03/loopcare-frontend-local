import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';

@Deprecated("Not used")
class ProgramCarousel extends StatefulWidget {
  final List<PhysicalProgram> programs;

  const ProgramCarousel({super.key, required this.programs});

  @override
  State<ProgramCarousel> createState() => _ProgramCarouselState();
}

@Deprecated("Not used")
class _ProgramCarouselState extends State<ProgramCarousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            padEnds: false,
            itemCount: widget.programs.length,
            controller: PageController(viewportFraction: .9),
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ProgramCard(
                  program: widget.programs[index],
                  size: const ProgramCardSize.small(),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.programs
              .mapIndexed(
                (index, el) => Hexagon(
                  width: 16,
                  height: 16,
                  borderRadius: 4.0,
                  innerWidget: Container(
                    color: currentPage == index ? AppColors.blueMid : AppColors.yellowLight,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
