import 'package:image/image.dart' as img;
import 'package:signals/signals.dart';

import '../base.dart';
import 'base.dart';

class BillboardImageFilter extends ImageFilterOperation {
  BillboardImageFilter(
    GraphNode src, {
    GraphNode? mask,
    img.Channel? maskChannel,
    num amount = 1,
    num grid = 10,
  })  : source = signal<GraphNode>(src),
        mask = signal<GraphNode?>(mask),
        maskChannel = signal<img.Channel>(img.Channel.luminance),
        amount = signal<num>(amount),
        grid = signal<num>(grid);

  final Signal<GraphNode> source;
  final Signal<num> amount;
  final Signal<num> grid;
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
    final result = img.billboard(
      img.Image.from(srcImg),
      mask: maskImg != null ? img.Image.from(maskImg) : null,
      grid: grid.value,
      amount: amount.value,
      maskChannel: maskChannel.value,
    );
    return result;
  });
}
