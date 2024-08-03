import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';

class AvatarOption {
  final String label;
  final SvgPicture? image;
  final AvatarTypeKey type;

  AvatarOption(this.label, this.image, this.type);
}
