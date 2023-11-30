import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  base: "/signals.dart/",
  integrations: [
    starlight({
      title: "Signals.dart",
      social: {
        github: "https://github.com/rodydavis/signals.dart",
      },
      sidebar: [
        {
          label: "Reference",
          items: [
            { label: "Overview", link: "/reference/overview" },
            { label: "Installing", link: "/reference/installing" },
            {
              label: "Core Methods",
              items: [
                { label: "Signal", link: "/reference/core/signal" },
                { label: "Computed", link: "/reference/core/computed" },
                { label: "Effect", link: "/reference/core/effect" },
                { label: "Untracked", link: "/reference/core/untracked" },
                { label: "Batch", link: "/reference/core/batch" },
                { label: "Connect", link: "/reference/core/connect" },
              ],
            },
            {
              label: "Value Types",
              items: [
                { label: "List", link: "/reference/value/list" },
                { label: "Set", link: "/reference/value/set" },
                { label: "Map", link: "/reference/value/map" },
                { label: "Iterable", link: "/reference/value/iterable" },
                { label: "Future", link: "/reference/value/future" },
                { label: "Stream", link: "/reference/value/stream" },
              ],
            },
            {
              label: "Flutter",
              items: [
                { label: "Watch", link: "/reference/flutter/watch" },
                {
                  label: "ValueListenable",
                  link: "/reference/flutter/value-listenable",
                },
                { label: "ValueNotifier", link: "/reference/flutter/value-notifier" },
              ],
            },
            { label: "DevTools", link: "/reference/flutter/devtools" },
          ],
        },
        {
          label: "Examples",
          autogenerate: { directory: "examples" },
        },
      ],
    }),
  ],
});
