import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:syntax_highlight_lite/syntax_highlight_lite.dart' hide Color;
import 'package:jaspr_content/components/_internal/code_block_copy_button.dart';
import 'package:jaspr_content/jaspr_content.dart';

class SafeCodeBlock extends CustomComponent {
  SafeCodeBlock({this.defaultLanguage = 'dart', this.grammars = const {}, this.codeTheme}) : super.base();

  final String defaultLanguage;
  final Map<String, String> grammars;
  final HighlighterTheme? codeTheme;

  bool _initialized = false;
  HighlighterTheme? _defaultTheme;

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node
        case ElementNode(tag: 'Code' || 'CodeBlock', :final children, :final attributes) ||
            ElementNode(tag: 'pre', children: [ElementNode(tag: 'code', :final children, :final attributes)])) {
      var language = attributes['language'];
      if (language == null && (attributes['class']?.startsWith('language-') ?? false)) {
        language = attributes['class']!.substring('language-'.length);
      }

      if (!_initialized) {
        try {
          Highlighter.initialize(['dart', 'yaml', 'bash', 'json', 'yml', 'sh']);
          for (final entry in grammars.entries) {
            Highlighter.addLanguage(entry.key, entry.value);
          }
        } catch (_) {}
        _initialized = true;
      }

      return AsyncBuilder(
        builder: (context) async {
          Highlighter? highlighter;
          final theme = codeTheme ?? (_defaultTheme ??= await HighlighterTheme.loadDarkTheme());
          final lang = language ?? defaultLanguage;
          try {
            highlighter = Highlighter(
              language: lang,
              theme: theme,
            );
          } catch (_) {
            // Fallback to plain text if language is not supported/registered
            highlighter = null;
          }

          return _SafeCodeBlockRender(
            source: children?.map((c) => c.innerText).join(' ') ?? '',
            highlighter: highlighter,
          );
        },
      );
    }
    return null;
  }

  @css
  static List<StyleRule> get styles => [
    css('.code-block', [
      css('&').styles(position: Position.relative()),
      css('button').styles(
        position: Position.absolute(top: 1.rem, right: 1.rem),
        opacity: 0,
        color: Colors.white,
        width: 1.25.rem,
        height: 1.25.rem,
        zIndex: ZIndex(10),
      ),
      css('&:hover button').styles(opacity: 0.75),
    ]),
  ];
}

class _SafeCodeBlockRender extends StatelessComponent {
  const _SafeCodeBlockRender({required this.source, this.highlighter, super.key});

  final String source;
  final Highlighter? highlighter;

  @override
  Component build(BuildContext context) {
    final codeblock = pre([
      code([if (highlighter != null) buildSpan(highlighter!.highlight(source)) else Component.text(source)]),
    ]);

    return div(classes: 'code-block', [CodeBlockCopyButton(), codeblock]);
  }

  Component buildSpan(TextSpan textSpan) {
    Styles? styles;

    if (textSpan.style case final style?) {
      styles = Styles(
        color: Color.value(style.foreground.argb & 0x00FFFFFF),
        fontWeight: style.bold ? FontWeight.bold : null,
        fontStyle: style.italic ? FontStyle.italic : null,
        textDecoration: style.underline ? TextDecoration(line: TextDecorationLine.underline) : null,
      );
    }

    if (styles == null && textSpan.children.isEmpty) {
      return Component.text(textSpan.text ?? '');
    }

    return span(styles: styles, [
      if (textSpan.text != null) Component.text(textSpan.text!),
      for (final t in textSpan.children) buildSpan(t),
    ]);
  }
}
