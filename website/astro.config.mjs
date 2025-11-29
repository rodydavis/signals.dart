import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      // site: "https://rodydavis.github.io/signals.dart",
      title: "Signals.dart",
      social: [
        {
          label: "GitHub",
          icon: "github",
          href: "https://github.com/rodydavis/signals.dart",
        },
      ],
      customCss: ["/src/styles/custom.css", "/src/fonts/font-face.css"],
      sidebar: [
        { label: "Reference", autogenerate: { directory: "reference" } },
        { label: "Core", autogenerate: { directory: "core" } },
        { label: "Flutter", autogenerate: { directory: "flutter" } },
        { label: "Mixins", autogenerate: { directory: "mixins" } },
        { label: "Async", autogenerate: { directory: "async" } },
        { label: "Value", autogenerate: { directory: "value" } },
        { label: "Utilities", autogenerate: { directory: "utilities" } },
        { label: "Guides", autogenerate: { directory: "guides" } },
      ],
    }),
  ],
});
