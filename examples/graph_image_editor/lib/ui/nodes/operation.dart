import 'base.dart';

abstract class ImageOperation extends GraphNode {
  List<GraphNode> get sources;
}
