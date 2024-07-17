import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';

class AvatarVariantOption {
  final SvgPicture? image;
  final AvatarTypeKey type;

  AvatarVariantOption(this.image, this.type);
}
