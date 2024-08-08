import 'package:image/image.dart' as img;
import 'package:signals/signals.dart';

import '../base.dart';
import 'base.dart';

class InvertImageFilter extends ImageFilterOperation {
  InvertImageFilter(
    GraphNode src, {
    GraphNode? mask,
    img.Channel? maskChannel,
    num amount = 1,
    img.Color? color,
  })  : source = signal<GraphNode>(src),
        mask = signal<GraphNode?>(mask),
        maskChannel = signal<img.Channel>(img.Channel.luminance);

  final Signal<GraphNode> source;
  final Signal<GraphNode?> mask;
  final Signal<img.Channel> maskChannel;

  @override
  List<GraphNode> get sources {
    return [
      source.value,
      if (mask.value != null) mask.value!,
    ];
  }

  @override
  late ReadonlySignal<img.Image> image = computed(() {
    final srcImg = source.value.image.value;
    final maskImg = mask.value?.image.value;
    final result = img.invert(
      img.Image.from(srcImg),
      mask: maskImg != null ? img.Image.from(maskImg) : null,
      maskChannel: maskChannel.value,
    );
    return result;
  });
}
