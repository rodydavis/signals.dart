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
          label: "Core",
          items: [
            { label: "Signal", link: "core/signal" },
            { label: "Computed", link: "core/computed" },
            { label: "Effect", link: "core/effect" },
            { label: "Untracked", link: "core/untracked" },
            { label: "Batch", link: "core/batch" },
          ],
        },
        { label: "Value", autogenerate: { directory: "value" } },
        { label: "Async", autogenerate: { directory: "async" } },
        {
          label: "Flutter",
          autogenerate: { directory: "flutter" },
        },
        {
          label: "Utilities",
          autogenerate: { directory: "utilities" },
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
