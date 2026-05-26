import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CopyMarkdown extends StatelessComponent {
  const CopyMarkdown({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'copy-markdown-container',
      attributes: {
        'onclick': '''
          (async (container) => {
            if (container.classList.contains('copied')) return;
            const btn = container.querySelector('.copy-markdown-btn');
            const tooltip = container.querySelector('.copy-markdown-tooltip');
            try {
              let path = window.location.pathname;
              if (!path || path === '/') {
                path = '/index';
              }
              const cleanPath = path.startsWith('/') ? path.substring(1) : path;
              const response = await fetch('/raw_markdown/' + cleanPath + '.md');
              if (!response.ok) throw new Error('Failed to fetch');
              const text = await response.text();
              await navigator.clipboard.writeText(text);
              
              tooltip.innerHTML = 'Copied!';
              container.classList.add('copied');
              
              setTimeout(() => {
                container.classList.remove('copied');
                tooltip.innerHTML = 'Copy Markdown';
              }, 2000);
            } catch (err) {
              console.error(err);
              tooltip.innerHTML = 'Failed to copy';
              container.classList.add('error');
              setTimeout(() => {
                container.classList.remove('error');
                tooltip.innerHTML = 'Copy Markdown';
              }, 2000);
            }
          })(this)
        '''
      },
      [
        RawText('''
          <style>
            .copy-markdown-container {
              position: relative;
              display: inline-block;
              margin-right: 8px;
            }
            .copy-markdown-btn {
              display: inline-flex;
              align-items: center;
              justify-content: center;
              width: 36px;
              height: 36px;
              border-radius: 8px;
              border: 1px solid var(--copy-btn-border, #cbd5e1);
              background-color: var(--copy-btn-bg, #ffffff);
              color: var(--copy-btn-color, #334155);
              cursor: pointer;
              transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
              padding: 0;
            }
            .copy-markdown-btn:hover {
              border-color: #3b82f6 !important;
              background-color: var(--copy-btn-hover-bg, #eff6ff) !important;
              color: #3b82f6 !important;
              transform: translateY(-1px);
              box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
            }
            .copy-markdown-container.copied .copy-markdown-btn {
              border-color: #10b981 !important;
              background-color: var(--copy-btn-copied-bg, #ecfdf5) !important;
              color: #10b981 !important;
              box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
            }
            .copy-markdown-container.error .copy-markdown-btn {
              border-color: #ef4444 !important;
              background-color: var(--copy-btn-error-bg, #fef2f2) !important;
              color: #ef4444 !important;
            }
            .copy-markdown-btn .check-icon {
              display: none;
            }
            .copy-markdown-container.copied .copy-markdown-btn .copy-icon {
              display: none;
            }
            .copy-markdown-container.copied .copy-markdown-btn .check-icon {
              display: inline-block;
            }
            .copy-markdown-tooltip {
              position: absolute;
              top: calc(100% + 8px);
              left: 50%;
              transform: translateX(-50%) translateY(-4px);
              padding: 6px 10px;
              font-size: 0.75rem;
              font-weight: 600;
              color: var(--tooltip-color);
              background-color: var(--tooltip-bg);
              border: 1px solid var(--tooltip-border);
              border-radius: 6px;
              white-space: nowrap;
              opacity: 0;
              visibility: hidden;
              pointer-events: none;
              transition: all 0.15s cubic-bezier(0.4, 0, 0.2, 1);
              box-shadow: var(--tooltip-shadow);
              z-index: 50;
            }
            .copy-markdown-tooltip::after {
              content: "";
              position: absolute;
              bottom: calc(100% - 5px);
              left: 50%;
              transform: translateX(-50%) rotate(45deg);
              width: 8px;
              height: 8px;
              background-color: var(--tooltip-bg);
              border-left: 1px solid var(--tooltip-border);
              border-top: 1px solid var(--tooltip-border);
              z-index: -1;
            }
            .copy-markdown-container:hover .copy-markdown-tooltip {
              opacity: 1;
              visibility: visible;
              transform: translateX(-50%) translateY(0);
            }
            .copy-markdown-container.copied {
              --tooltip-bg: #10b981;
              --tooltip-border: #10b981;
              --tooltip-color: #ffffff;
            }
            .copy-markdown-container.error {
              --tooltip-bg: #ef4444;
              --tooltip-border: #ef4444;
              --tooltip-color: #ffffff;
            }
            :root {
              --copy-btn-bg: #ffffff;
              --copy-btn-border: #cbd5e1;
              --copy-btn-color: #334155;
              --copy-btn-hover-bg: #eff6ff;
              --copy-btn-copied-bg: #ecfdf5;
              --copy-btn-error-bg: #fef2f2;
              --tooltip-bg: #ffffff;
              --tooltip-color: #0f172a;
              --tooltip-border: #cbd5e1;
              --tooltip-shadow: 0 4px 12px rgba(15, 23, 42, 0.08), 0 2px 4px rgba(15, 23, 42, 0.04);
            }
            html.dark, [data-theme="dark"] {
              --copy-btn-bg: #1e293b;
              --copy-btn-border: #475569;
              --copy-btn-color: #94a3b8;
              --copy-btn-hover-bg: #0f172a;
              --copy-btn-copied-bg: #064e3b;
              --copy-btn-error-bg: #7f1d1d;
              --tooltip-bg: #1e293b;
              --tooltip-color: #f8fafc;
              --tooltip-border: #475569;
              --tooltip-shadow: 0 4px 12px rgba(0, 0, 0, 0.3), 0 2px 4px rgba(0, 0, 0, 0.2);
            }
          </style>
        '''),
        button(
          classes: 'copy-markdown-btn',
          [
            // Copy icon SVG
            svg(
              [
                rect([], attributes: {'x': '9', 'y': '9', 'width': '13', 'height': '13', 'rx': '2', 'ry': '2'}),
                path([], attributes: {'d': 'M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1'}),
              ],
              classes: 'copy-icon',
              attributes: {
                'width': '16',
                'height': '16',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2.5',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
            ),
            // Check icon SVG
            svg(
              [
                polyline([], attributes: {'points': '20 6 9 17 4 12'}),
              ],
              classes: 'check-icon',
              attributes: {
                'width': '16',
                'height': '16',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2.5',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
            ),
          ],
        ),
        span(
          classes: 'copy-markdown-tooltip',
          [
            Component.text('Copy Markdown'),
          ],
        ),
      ],
    );
  }
}
