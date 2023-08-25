import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class PromptsContainer extends StatelessWidget {
  const PromptsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      child: const ScrollableContainer(
        child: Center(
          child: AutoSizeText(
            'Other content under the Grid Other content under the Grid OtHLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8her content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid OtHLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8 HLS playlist m3u8her content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid Other content under the Grid',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.darkGreen),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
