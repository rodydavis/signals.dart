import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      // site: "https://rodydavis.github.io/signals.dart",
      title: "Signals.dart",
      social: {
        github: "https://github.com/rodydavis/signals.dart",
      },
      customCss: ["/src/styles/custom.css", "/src/fonts/font-face.css"],
      sidebar: [
        {
          label: "Reference",
          // autogenerate: { directory: "reference" },
          items: [
            { label: "Installing", link: "reference/install" },
            { label: "Overview", link: "reference/overview" },
          ],
        },
        {
          label: "Dart",
          items: [
            {
              label: "Core",
              items: [
                { label: "Signal", link: "dart/core/signal" },
                { label: "Computed", link: "dart/core/computed" },
                { label: "Effect", link: "dart/core/effect" },
                { label: "Untracked", link: "dart/core/untracked" },
                { label: "Batch", link: "dart/core/batch" },
              ],
            },
            { label: "Value", autogenerate: { directory: "dart/value" } },
            { label: "Async", autogenerate: { directory: "dart/async" } },
            {
              label: "Utilities",
              autogenerate: { directory: "dart/utilities" },
            },
          ],
        },
        {
          label: "Flutter",
          autogenerate: { directory: "flutter" },
        },
        {
          label: "Guides",
          autogenerate: { directory: "guides" },
        },
        { label: "Examples", link: "examples" },
      ],
    }),
  ],
});
