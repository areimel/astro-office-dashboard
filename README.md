# Office Dashboard

A responsive, bento-style dashboard for office displays built with Astro.js and Tailwind CSS. This project is designed to provide a scalable, performant dashboard that works seamlessly across various screen sizes, from laptops to 4K TVs.

## Project Overview

This dashboard is built on top of the Astroship template, customized specifically for office display needs. It features:

- 📱 Responsive bento-grid layout using viewport units
- ⚡ Optimized performance with Astro.js
- 🎨 Utility-first styling with Tailwind CSS
- ♿ Accessibility-first design
- 📦 Modular widget system

## Tech Stack

- **Framework**: [Astro.js](https://astro.build)
- **Styling**: [Tailwind CSS](https://tailwindcss.com)
- **Icons**: [Astro Icon](https://www.npmjs.com/package/astro-icon)
- **Typography**: Inter & Bricolage Grotesque variable fonts
- **Development**: TypeScript, ESLint

## Getting Started

1. Clone the repository:
```bash
git clone [your-repo-url]
cd office-dashboard
```

2. Install dependencies:
```bash
pnpm install
```

3. Start development server:
```bash
pnpm dev
```

4. Build for production:
```bash
pnpm build
```

## Project Structure

```
/
├── public/          # Static assets
├── src/
│   ├── components/  # Reusable UI components & widgets
│   │   └── widgets/ # Dashboard widgets
│   ├── layouts/     # Layout components
│   ├── pages/       # Page components
│   └── styles/      # Global styles
└── package.json
```

## Widget Development

Widgets are the core building blocks of the dashboard. Each widget should:

- Be responsive using viewport units (`vw`, `vh`, `vmin`, `vmax`)
- Implement lazy loading when below the fold
- Include proper ARIA labels and keyboard navigation
- Follow the established naming convention: `widget-name.astro`

Example widget structure:
```astro
---
// widget-name.astro
interface Props {
    title: string;
    // ... other props
}

const { title } = Astro.props;
---

<div class="widget" role="region" aria-label={title}>
    <!-- Widget content -->
</div>

<style>
    .widget {
        /* Responsive styling */
    }
</style>
```

## Development Guidelines

1. **Responsive Design**
   - Use viewport units for fluid scaling
   - Test across multiple screen sizes
   - Focus on large display optimization

2. **Performance**
   - Implement lazy loading for below-fold widgets
   - Optimize assets and images
   - Minimize client-side JavaScript

3. **Accessibility**
   - Include ARIA labels
   - Ensure keyboard navigation
   - Maintain WCAG contrast ratios

4. **Code Style**
   - Use TypeScript
   - Follow functional programming principles
   - Implement modular, reusable components

## Contributing

1. Create a feature branch (`git checkout -b feature/widget-name`)
2. Commit changes (`git commit -am 'Add widget-name'`)
3. Push to branch (`git push origin feature/widget-name`)
4. Open a Pull Request

## License

[Your chosen license]

## Acknowledgments

This project is built on top of [Astroship](https://github.com/surjithctly/astroship), a starter template by [Web3Templates](https://web3templates.com).
