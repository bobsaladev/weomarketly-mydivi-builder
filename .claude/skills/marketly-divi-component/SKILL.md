---
name: marketly-divi-component
description: Authors custom MARKETLY/MyDivi Divi builder modules from schema.json, body.html, styles.less, and optional script.js. Use when building or editing et_pb_mydivi_* modules, Card Factory components, Handlebars module templates, or when Bob asks for new MARKETLY site components on WEOMARKETLY/MARKETLY.
---

# MARKETLY Divi components

Custom modules for MARKETLY sites ship as **four files** inside one folder under **`MODULES/`** on Bob’s Mac: `/Users/bobsala/Desktop/WEOMARKETLY/MODULES/<ModuleName>/` (see [preferences.md](/cursor/stores/bc-f811de4f-0251-4ac1-b459-09e239894db9/preferences.md)). Mirror sibling modules (e.g. `ACCORDION/`):

| File | Required | Role |
|------|----------|------|
| `schema.json` | Yes | Divi builder fields (labels, types, repeaters) |
| `body.html` | Yes | Handlebars markup rendered on the front end |
| `styles.less` | Yes | Scoped LESS (often `style.less` in some trees; keep naming consistent with siblings) |
| `script.js` | If interactive | jQuery IIFE; omit when CSS-only |

Reference implementation: [examples/accordion-standard/](examples/accordion-standard/).

## Workflow

```
Task progress:
- [ ] Name module (BEM root class; matches `et_pb_mydivi_*` slug in layouts)
- [ ] schema.json — fields editors need only
- [ ] body.html — map every schema key; triple-brace rich text
- [ ] styles.less — base + `#main #et-boc` band overrides
- [ ] script.js — namespaced events, a11y if toggles
- [ ] Smoke in Divi Visual Builder + band-dark / band-light sections
```

**Order:** schema → body → styles → script.

## schema.json

- Top-level keys are **module settings** exposed in Divi.
- **`type: "repeater"`** with nested `fields` for lists (FAQ items, slides, cards).
- Common field types:
  - `text`, `tiny_mce` (rich HTML in body via `{{{content}}}`)
  - `select` + `options` map (value → label)
  - `yes_no_button` with `options` `off` / `on`
- Match **option values** to Handlebars (`makeactive` → `on` in `#ifvalue`).

Do not duplicate Divi globals (padding, background) unless the module truly needs them.

## body.html (Handlebars)

Patterns from MARKETLY modules:

- Wrapper: `class="component-root {{module-class}} {{module-counter}}"` and optional `id="{{module-id}}"`.
- **Repeaters:** `{{#each items}}` … `{{/each}}` (name the array after the schema key).
- **Conditionals:** `{{#ifvalue fieldname equals="on"}}` … `{{else}}` … `{{/ifvalue}}`.
- **Unescaped HTML:** `{{{title}}}`, `{{{content}}}` for TinyMCE; use `{{title}}` only for plain text.
- **Dynamic tags:** `<{{headingtag}} class="...">` when editors pick h2–h6.
- **Accessibility:** `role="button"`, `tabindex="0"`, `aria-expanded` on toggles; set initial state in markup for “open by default”.

Keep semantics out of styles: structure and ARIA live in body.html.

## styles.less

- Root class matches body (e.g. `.accordion-standard`).
- Prefer site tokens: `var(--color-primary)`, `--color-secondary`, `--color-accenta`, `--color-accentb`, `--heading-tertiary`, etc.
- Reset list/module bleed: `list-style: none`, explicit borders, `!important` only where Divi parent rules win.
- **Theme bands:** nest overrides under `#main #et-boc` for `.band-dark`, `.band-dark-alt`, `.band-light`, `.band-light-alt` on the section/module_class (see example).
- Pseudo-elements for chevrons/lines; `transition` on interactive states.

## script.js

- Wrap in `(function ($) { ... })(jQuery);`
- Delegate events: `$(document).on("click.moduleSlug", ".root .trigger", ...)`
- Use a **unique event namespace** per module (e.g. `.accordionStandard`) to avoid collisions.
- Keyboard: handle `Enter` and `Space` on focusable titles.
- Prefer `slideToggle` / `stop(false, true)` for panels; sync `.active` and `aria-expanded` with visible state.

Skip `script.js` when behavior is pure CSS.

## Layout JSON usage

Published pages reference modules as shortcodes, e.g. `et_pb_mydivi_accordion` with child `et_pb_mydivi_accordion_item` fields. New modules need:

1. PHP/module registration in MARKETLY plugin (not in this skill’s file set).
2. Stable `admin_title` / field attrs aligned with schema labels.

QC/layout work in this Project touches **text in existing** `et_pb_mydivi_*` attrs; new components are authored in the MARKETLY repo first, then used in layout JSON.

## Checklist before handoff

- [ ] Every schema field appears in body (or is intentionally unused-documented).
- [ ] Repeater empty state does not break markup.
- [ ] Works on light and dark bands without unreadable contrast.
- [ ] No hardcoded client copy in schema defaults (site-specific copy lives in layouts/briefs).
- [ ] Script does not bind duplicate handlers on Divi AJAX reload (delegated `document` events).

## Additional resources

- Field patterns and band tokens: [reference.md](reference.md)
- Full accordion sample: [examples/accordion-standard/](examples/accordion-standard/)

## Install as Cursor skill

Copy this folder to **`~/.cursor/skills/marketly-divi-component/`** on your Mac (personal), or **`.cursor/skills/marketly-divi-component/`** in a repo shared with the team. Do not place under `~/.cursor/skills-cursor/`.