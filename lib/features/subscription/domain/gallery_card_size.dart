import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_card_size.freezed.dart';

const smallHeightCard = 250.0;
const largeHeightCard = 400.0;

@freezed
class GalleryCardSize with _$GalleryCardSize {
  const factory GalleryCardSize.small() = Small;

  const factory GalleryCardSize.large() = Large;
}
