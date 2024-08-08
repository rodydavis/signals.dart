import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'package:image/image.dart' as img;

import 'convert.dart';

abstract class GraphNode {
  final offset = signal<Offset>(Offset.zero);

  String get id => 'graph_node_$hashCode';

  ReadonlySignal<img.Image> get image;

  late final export = computedAsync(() async {
    final image = this.image.value;
    return await convertImageToFlutterUi(image);
  });
}
