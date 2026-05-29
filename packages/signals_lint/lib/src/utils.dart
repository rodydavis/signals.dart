import 'package:analyzer/dart/element/type.dart';

extension ObjectUtils<T> on T? {
  R? safeCast<R>() {
    final that = this;
    if (that is R) return that;
    return null;
  }

  R? convert<R>(R Function(T)? cb) {
    final that = this;
    if (that == null) return null;
    return cb?.call(that);
  }
}

bool isTypeOf(DartType? type, String name, String packageName) {
  if (type == null) return false;
  if (type is InterfaceType) {
    var element = type.element;
    if (element.name == name) {
      final uri = element.library.firstFragment.source.uri.toString();
      if (uri.startsWith('package:$packageName/')) {
        return true;
      }
    }
    for (final supertype in element.allSupertypes) {
      var superElement = supertype.element;
      if (superElement.name == name) {
        final uri = superElement.library.firstFragment.source.uri.toString();
        if (uri.startsWith('package:$packageName/')) {
          return true;
        }
      }
    }
  }
  return false;
}
