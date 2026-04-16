/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'dart:io';

// Server-specific Jaspr import.
import 'package:jaspr/server.dart';

import 'package:jaspr_content/components/callout.dart';
import 'package:jaspr_content/components/code_block.dart';
import 'package:jaspr_content/components/github_button.dart';
import 'package:jaspr_content/components/header.dart';
import 'package:jaspr_content/components/image.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/components/tabs.dart';
import 'package:jaspr_content/components/theme_toggle.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

import 'components/clicker.dart';
import 'components/starlight.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

SidebarGroup _autoGen(String label, String directory) {
  final dir = Directory('content/$directory');
  if (!dir.existsSync()) return SidebarGroup(title: label, links: []);

  final List<SidebarLink> links = [];
  for (var file in dir.listSync().whereType<File>()) {
    if (file.path.endsWith('.md')) {
      final content = file.readAsStringSync();
      final titleMatch = RegExp(r'^title:\s*"?([^"\n]+)"?$', multiLine: true).firstMatch(content);
      final title = titleMatch?.group(1)?.trim() ?? file.uri.pathSegments.last.replaceAll('.md', '');

      final href = '/$directory/${file.uri.pathSegments.last.replaceAll('.md', '')}';
      links.add(SidebarLink(text: title, href: href));
    }
  }

  // Sort alphabetically for simplicity if order is not strict (we could map and sort by order)
  links.sort((a, b) => a.text.toLowerCase().compareTo(b.text.toLowerCase()));

  return SidebarGroup(title: label, links: links);
}

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  // Starts the app.
  //
  // [ContentApp] spins up the content rendering pipeline from jaspr_content to render
  // your markdown files in the content/ directory to a beautiful documentation site.
  runApp(
    ContentApp(
      // Enables mustache templating inside the markdown files.
      templateEngine: MustacheTemplateEngine(),
      parsers: [
        MarkdownParser(),
      ],
      extensions: [
        // Adds heading anchors to each heading.
        HeadingAnchorsExtension(),
        // Generates a table of contents for each page.
        TableOfContentsExtension(),
      ],
      components: [
        // The <Info> block and other callouts.
        Callout(),
        // The Tabs block
        Tabs(),
        // Adds syntax highlighting to code blocks.
        CodeBlock(),
        // Adds a custom Jaspr component to be used as <Clicker/> in markdown.
        CustomComponent(
          pattern: 'Clicker',
          builder: (_, props, _) => Clicker(),
        ),
        CustomComponent(
          pattern: 'CardGrid',
          builder: (_, props, child) => CardGrid(props: props, children: child != null ? [child] : []),
        ),
        CustomComponent(
          pattern: 'Card',
          builder: (_, props, child) => Card(props: props, children: child != null ? [child] : []),
        ),
        // Adds zooming and caption support to images.
        Image(zoom: true),
      ],
      layouts: [
        // Out-of-the-box layout for documentation sites.
        DocsLayout(
          header: Header(
            title: 'Signals.dart',
            logo: '/images/logo.svg', // Might need to copy logo
            items: [
              // Enables switching between light and dark mode.
              ThemeToggle(),
              // Shows github stats.
              GitHubButton(repo: 'rodydavis/signals.dart'),
            ],
          ),
          sidebar: Sidebar(
            groups: [
              // Adds navigation links to the sidebar.
              SidebarGroup(
                links: [
                  SidebarLink(text: "Overview", href: '/'),
                ],
              ),
              _autoGen('Reference', 'reference'),
              _autoGen('Core', 'core'),
              _autoGen('Flutter', 'flutter'),
              _autoGen('Mixins', 'mixins'),
              _autoGen('Async', 'async'),
              _autoGen('Value', 'value'),
              _autoGen('Utilities', 'utilities'),
              _autoGen('Guides', 'guides'),
            ],
          ),
        ),
      ],
      theme: ContentTheme(
        // Customizes the default theme colors.
        primary: ThemeColor(ThemeColors.yellow.$600, dark: ThemeColors.yellow.$500),
        background: ThemeColor(ThemeColors.slate.$50, dark: ThemeColors.slate.$950),
        colors: [
          ContentColors.quoteBorders.apply(ThemeColors.yellow.$500),
        ],
      ),
    ),
  );
}
