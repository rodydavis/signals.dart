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
                { label: "Signal", link: "/reference/signal" },
                { label: "Computed", link: "/reference/computed" },
                { label: "Effect", link: "/reference/effect" },
                { label: "Untracked", link: "/reference/untracked" },
                { label: "Batch", link: "/reference/batch" },
                { label: "Connect", link: "/reference/connect" },
              ],
            },
            {
              label: "Value Types",
              items: [
                { label: "List", link: "/reference/list" },
                { label: "Set", link: "/reference/set" },
                { label: "Map", link: "/reference/map" },
                { label: "Iterable", link: "/reference/iterable" },
                { label: "Future", link: "/reference/future" },
                { label: "Stream", link: "/reference/stream" },
              ],
            },
            {
              label: "Flutter",
              items: [
                { label: "Watch", link: "/reference/watch" },
                {
                  label: "ValueListenable",
                  link: "/reference/value-listenable",
                },
                { label: "ValueNotifier", link: "/reference/value-notifier" },
              ],
            },
            { label: "DevTools", link: "/reference/devtools" },
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
