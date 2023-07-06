import 'package:flutter/foundation.dart' show objectRuntimeType;

class ImageSubtitle {
  final int number;
  final int start;
  final int end;
  final String src;

  const ImageSubtitle({
    required this.number,
    required this.start,
    required this.end,
    required this.src,
  });

  ImageSubtitle.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        start = json['start'],
        end = json['end'],
        src = json['src'];

  static get empty => const ImageSubtitle(
        number: -1,
        start: -1,
        end: -1,
        src: '',
      );

  @override
  String toString() {
    return '${objectRuntimeType(this, 'ImageSubtitle')}('
        'number: $number, '
        'start: $start, '
        'end: $end, '
        'src: $src)';
  }
}
