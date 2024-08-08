import 'dart:typed_data';
import 'dart:ui';

import 'package:signals/signals.dart';

import 'package:image/image.dart' as img;

import 'base.dart';

class SourceImage extends GraphNode {
  final source = signal<Uint8List>(Uint8List(0));

  @override
  late final image = computed(() {
    if (source.value.isNotEmpty) {
      final result = img.decodePng(source.value);
      if (result != null) return result;
    }
    return img.Image.empty();
  });

  late final imageSize = computed(() {
    return Size(
      image.value.width.toDouble(),
      image.value.height.toDouble(),
    );
  });

  late final imageRect = computed(
    () => offset.value & imageSize.value,
  );
}
