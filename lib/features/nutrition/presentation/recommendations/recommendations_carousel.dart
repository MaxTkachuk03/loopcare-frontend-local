import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recommendations/recommendation_recipe.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recommendations/recommendation_card.dart';

class RecommendationsCarousel extends StatefulWidget {
  final List<RecommendationRecipe> recommendations;

  const RecommendationsCarousel({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  @override
  State<RecommendationsCarousel> createState() => _RecommendationsCarouselState();
}

class _RecommendationsCarouselState extends State<RecommendationsCarousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: false,
      itemCount: widget.recommendations.length,
      controller: PageController(viewportFraction: .9),
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: RecommendationCard(
            recommendation: widget.recommendations[index],
            size: const RecommendationCardSize.large(),
          ),
        );
      },
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
