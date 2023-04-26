import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EducationAppBar extends StatefulWidget {
  const EducationAppBar({Key? key}) : super(key: key);

  @override
  _EducationAppBarState createState() => _EducationAppBarState();
}

class _EducationAppBarState extends State<EducationAppBar> {
  final GlobalKey _appBarKey = GlobalKey();
  double _sliverBarHeight = 0;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderObject = _appBarKey.currentContext?.findRenderObject();
      if (renderObject is RenderBox) {
        setState(() {
          _sliverBarHeight = renderObject.size.height;
          _isLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.orange,
      expandedHeight: _sliverBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background:
        Opacity(
          opacity: _isLoaded ? 1 : 0,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 36),
                key: _appBarKey,
                child: Column(
                  children: const [
                    Text(
                      'Taking one step at a time will have a huge impact',
                      style: TextStyle(
                        fontFamily: ThemeConstants.bitterFontFamily,
                        color: AppColors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image(
                        image: AppImages.educationVideoPreview,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
