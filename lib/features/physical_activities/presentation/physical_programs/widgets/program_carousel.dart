import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';
import 'package:collection/collection.dart';

class ProgramCarousel extends StatefulWidget {
  final List<PhysicalProgram> programs;

  const ProgramCarousel({Key? key, required this.programs}) : super(key: key);

  @override
  _ProgramCarouselState createState() => _ProgramCarouselState();
}

class _ProgramCarouselState extends State<ProgramCarousel> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.programs.length,
            // controller: PageController(viewportFraction: 0.7),
            onPageChanged: _onPageChanged,
            itemBuilder: (_, index) {
              return Transform.translate(
                offset: Offset(-10, 0),
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
    print(index);
    setState(() {
      currentPage = index;
    });
  }
}
