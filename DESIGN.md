# Portfolio website: design brief

Personal portfolio for **Žan V. Dragan**, software engineer (Ljubljana, Slovenia).
It is one scrolling page with anchored sections. Build it from the reference files in `reference/`, use the files in `assets/` as they are, and follow this brief.

## What's in this folder

### `reference/`: design specs (HTML mockups)
| File | What it is |
|---|---|
| `desktop.html` | **The main reference.** The full page. It is already fluid and adapts from wide desktop to phone width. |
| `mobile-hero.html` | Top of the page at 390px wide. |
| `mobile-experience.html` | Experience section at 390px wide. |
| `mobile-menu.html` | The open mobile navigation menu (a full-screen overlay). |
| `og-image.html` | Source of the social preview image (already exported to `assets/og-image.png`). |
| `favicon.html`, `favicon-sizes.html` | Source of the favicon and how it looks at real sizes (already exported to `assets/`). |

The reference files are static mockups exported from a design canvas. All styles are inline and there is no build setup.
- Treat them as the spec for **layout, spacing, type, colour and copy**. Do not ship them as they are.
- Copy is final unless marked as a placeholder below. Keep the wording exactly.
- The mobile files are fixed 390×844 frames that link to each other. On the real site they are **breakpoints of the same page**, not separate pages.

### `assets/`: final, ship these as they are
| File | Use |
|---|---|
| `favicon.ico` | 16/32/48 multi-size icon; serve at `/favicon.ico` |
| `favicon.svg` | Scalable favicon; the letter is already outlined, so no font is needed |
| `favicon-16.png`, `favicon-32.png` | PNG fallbacks (the 16px version has no dot by design) |
| `apple-touch-icon.png` | 180×180 iOS home-screen icon |
| `icon-192.png`, `icon-512.png` | Web manifest icons |
| `site.webmanifest` | Web app manifest that references the icons above |
| `og-image.png` | 1200×630 social preview image (Open Graph / Twitter card) |

Put all of these in the site's public root.

```html
<link rel="icon" href="/favicon.ico" sizes="48x48">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#F6F6F3">

<title>Žan V. Dragan — Software Engineer</title>
<meta name="description" content="[DESCRIPTION, ~150 characters]">
<meta property="og:type" content="website">
<meta property="og:url" content="https://[DOMAIN]/">
<meta property="og:title" content="Žan V. Dragan — Software Engineer">
<meta property="og:description" content="[DESCRIPTION]">
<meta property="og:image" content="https://[DOMAIN]/og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Backend systems, built to deliver. Žan V. Dragan, software engineer, Ljubljana, Slovenia.">
<meta name="twitter:card" content="summary_large_image">
```
`og:image` must be an absolute URL.

## Implementation guidance

- **Stack:** Zola (static site generator), run through Docker so nothing is installed on the host. Pinned image in the `Makefile` (`ghcr.io/getzola/zola:v0.23.6`). `make serve` runs the dev server on http://localhost:8080; `make build` writes `public/`. Plain CSS and one small JS file (mobile menu); no Node toolchain.
- Move the inline styles into a stylesheet or component styles built on the design tokens below. Don't keep them inline.
- Fonts are self-hosted in `static/fonts/` as variable woff2 files (from `@fontsource-variable/*`) with `display=swap`. Both the latin and **latin-ext** subsets are included, because latin-ext is needed for Ž/ž.
- Section anchors: `#top`, `#work`, `#stack`, `#projects`, `#open-source`, `#contact`. Use smooth scrolling, and turn it off when the user has `prefers-reduced-motion` set.
- The experience entries, stack groups, projects and open-source repos are repeated blocks. They are driven by TOML files in `data/` (`experience.toml`, `stack.toml`, `projects.toml`, `opensource.toml`), rendered by the partials in `templates/partials/`. Site-wide values (domain, description, email, GitHub, LinkedIn) are in `config.toml`.
- **Hosting:** Cloudflare (static output from `make build`; deploy not set up yet).
- **Source of truth:** `reference/` and `assets/` are the original handoff. The shipped copies of the assets live in `static/`; the manifest there is the edited one.
- **Branch:** `master` is the main branch.

## Design tokens

### Colour
| Token | Value | Use |
|---|---|---|
| `ground` | `#F6F6F3` | Page background |
| `surface` | `#FFFFFF` | Cards, stats strip, stack grid, tags |
| `ink` | `#121417` | Primary text, dark surfaces (spec card, featured card, contact section, mobile menu, favicon) |
| `text-2` | `#3A3E44` | Body copy |
| `muted` | `#5B6068` | Secondary text, dates, labels |
| `rule` | `#DCDDD8` | Borders and dividers on light surfaces |
| `accent` | `#047857` | Highlights, section numbers, hover on light surfaces |
| `accent-on-dark` | `#34D399` | Highlights and hover on dark surfaces. `#047857` is too dark to read on `ink`. |
| `hover-shade` | `#ECEDE8` | Row hover background |
| On dark: text | `#E9EAE6`, headings `#FFFFFF`, muted `#9BA1A8`, rules `#2A2E34` | |

### Typography
- **Space Grotesk** 500/600: headings, stat numbers, stack values, open-source repo names.
- **Inter** 400/500/600: body text and UI.
- **JetBrains Mono** 400/500: eyebrow labels, dates, tags, section numbers, the `whoami` card, the wordmark, the email button.

| Element | Size / weight / tracking |
|---|---|
| Hero H1 | `clamp(44px, 6.4vw, 84px)`, 600, line-height 1.02, -0.035em (mobile: 42px) |
| Section H2 | 48px, 600, -0.03em (mobile: 34px) |
| Contact H2 | `clamp(44px, 7vw, 96px)`, 600, line-height 1, -0.04em |
| Hero lead | 19px, line-height 1.6 (mobile: 16px) |
| Body | 16px, line-height 1.6 |
| Experience company | 28px Space Grotesk 600 |
| Tags | 12px mono, 4px 10px padding, 1px `rule` border, radius 6px |
| Eyebrow / labels | 12–13px mono, letter-spacing 0.04–0.06em, uppercase |

### Layout and spacing
- Content container: `max-width: 1200px`, horizontal padding 32px (20px on mobile).
- Section spacing: 128px top padding on desktop, roughly 72px on mobile.
- Radii: buttons `999px` (pill); large cards 16px; small cards 12px; tags 6px.
- Layout uses flex and grid with `flex-wrap` / `auto-fit`, so sections stack naturally at narrow widths. Keep that behaviour.

## Sections (top to bottom)

1. **Header:** sticky, translucent `ground` with blur and a bottom rule. Wordmark `žan.v.dragan` with the dots in accent. Links: Experience, Stack, Projects, Open source, plus a pill "Get in touch" button. On mobile this becomes the wordmark and a menu icon that opens the overlay in `mobile-menu.html`.
2. **Main (top of page):** eyebrow, H1 "Backend systems, built to **deliver**." ("deliver" in accent), lead paragraph, and a "See my work" button (solid ink). There is no CV download; the page itself is the CV. Beside them sits the dark `whoami` terminal card, ending with "→ contributor to open-source".
3. **Stats strip:** white band with 3 figures: 9+ years, 4 languages, 3 API styles.
4. **01 Experience:** ruled rows, each with dates and location, company, a one-line descriptor, a summary and tech tags. Education line below the rows.
5. **02 Stack:** grid of 6 groups.
6. **03 Side projects:** 2 featured cards (Ledger service on dark, Slumber Mill on white, each with a small decorative motif marked `aria-hidden`), then 3 smaller cards. "All repositories on GitHub" link.
7. **04 Open source:** list of 5 upstream repos, each a full-row link.
8. **05 Contact:** dark section with a large H2, an email pill button, and a footer with ©, GitHub, LinkedIn and "Back to top".

## Interaction states

All transitions are 150ms ease. Apply every hover style to `:focus-visible` as well.

| Element | Hover / focus |
|---|---|
| Text links on light surfaces | Colour → `accent` |
| Pill buttons ("Get in touch", "See my work", email button) | Background and border → `accent`, text → `#FFFFFF` |
| Open-source rows | Background `hover-shade`. The shade extends 16px past the text on both sides; the reference does this with `box-shadow: -16px 0 0 …, 16px 0 0 …`. Text → `accent`. |
| Links on dark surfaces (footer links, "View source" on the Ledger card) | Colour → `accent-on-dark` |
| Mobile menu links | Colour → `accent-on-dark` |

## Accessibility (keep what the reference already does)

- Use real `<a href>` and `<button>` elements; the mobile menu toggle should be a `<button>` with `aria-expanded`.
- Interactive targets are at least 44px tall.
- Decorative SVGs and motifs use `aria-hidden="true"`; icon-only controls have an `aria-label`.
- Text contrast is 4.5:1 or better. That's why dark surfaces use `#34D399` rather than `#047857`.
- Use `<html lang="en">`, a meaningful `<title>`, and landmarks (`header`, `nav`, `main`, `section` with headings).

## Decisions and open items

- **No CV download.** The page is the CV, so the "Download CV" button and the mobile menu "CV (PDF)" link from the mockups were removed.
- **Project links** point at the real repos: `ledger-beetle`, `slumber-mill`, `ddv-reporter`, `accountant` (Finances tracker), `loterija` (Lottery scraper), all under `github.com/zanvd`.
- **Manifest:** `theme_color` is `#F6F6F3` to match the `<meta name="theme-color">`. `display` stays `browser`, so the site is not an installable app.
- **Mobile breakpoint:** 720px. Below it the header becomes the wordmark plus a menu button, and the overlay from `mobile-menu.html` is a `<div id="menu">` toggled by `static/menu.js` (`aria-expanded`, Escape closes, link click closes, page scroll locked). Without JavaScript the plain header links stay visible.
- **Mobile copy:** The mockup's shorter eyebrow, shorter lead and three-row `whoami` card are used below 720px. Experience summaries and all tags stay visible on mobile, even though `mobile-experience.html` omits them.
- **External links** (GitHub, LinkedIn, project repos, open-source repos) open in a new tab with `rel="noopener noreferrer"`. Anchors and `mailto:` links stay in the same tab.
- **Footer year** is generated at build time.
- **Domain and meta description:** `zanvd.dev` (`base_url`) and the description are set in `config.toml` and confirmed.

## Contact details used

- Email: `zan.v.dragan@gmail.com`
- GitHub: `https://github.com/zanvd`
- LinkedIn: `https://www.linkedin.com/in/zan-v-dragan/`
