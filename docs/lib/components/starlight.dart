import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CardGrid extends StatelessComponent {
  const CardGrid({super.key, required this.props, required this.children});

  final Map<String, dynamic> props;
  final List<Component> children;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6 mt-8',
      children,
    );
  }
}

class Card extends StatelessComponent {
  const Card({super.key, required this.props, required this.children});

  final Map<String, dynamic> props;
  final List<Component> children;

  @override
  Component build(BuildContext context) {
    final title = props['title']?.toString() ?? '';
    return div(
      classes: 'flex flex-col p-6 border border-slate-200 dark:border-slate-800 rounded-xl bg-slate-50 dark:bg-slate-900 gap-3 shadow-sm',
      [
        div(classes: 'flex items-center gap-2', [
          h3(classes: 'm-0 text-xl font-semibold', [.text(title)]),
        ]),
        div(classes: 'text-sm text-slate-600 dark:text-slate-400 flex flex-col gap-2', children),
      ]
    );
  }
}
