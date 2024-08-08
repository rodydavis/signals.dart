import '../base.dart';
import 'base.dart';
import 'billboard.dart';
import 'invert.dart';
import 'monochrome.dart';

final filters = <String, ImageFilterOperation Function(GraphNode)>{
  'Monochrome': (val) => MonochromeImageFilter(val),
  'Invert': (val) => InvertImageFilter(val),
  'Billboard': (val) => BillboardImageFilter(val),
};
