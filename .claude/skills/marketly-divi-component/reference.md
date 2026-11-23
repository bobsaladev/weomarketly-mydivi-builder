# MARKETLY module reference

## schema.json field types (common)

| `type` | Editor UI | Body binding |
|--------|-----------|--------------|
| `text` | Single line | `{{field}}` or `{{{field}}}` if HTML allowed |
| `tiny_mce` | WYSIWYG | Always `{{{field}}}` |
| `select` | Dropdown | Compare in `#ifvalue` or print `{{field}}` as tag name |
| `yes_no_button` | Toggle | `#ifvalue field equals="on"` |

Repeaters:

```json
"items": {
  "type": "repeater",
  "fields": { "...": { "label": "...", "type": "..." } }
}
```

## Handlebars helpers (MARKETLY)

| Construct | Use |
|-----------|-----|
| `{{#each items}}` | Repeater rows |
| `{{#ifvalue x equals="on"}}` | Yes/no and select values |
| `{{#if module-id}}` | Optional module id attribute |
| `{{{var}}}` | HTML content |
| `{{module-class}}` | Divi module_class passthrough |
| `{{module-counter}}` | Unique instance suffix |

## LESS band context

Sections use `module_class` bands such as `band-dark`, `band-light`, `band-hero-alt`. Override component colors inside:

```less
#main #et-boc {
  .your-component { /* default in section */ }
  .band-dark .your-component > li { /* dark band */ }
  .band-light .your-component > li { /* light band */ }
}
```

## script.js template

```javascript
(function ($) {
  function handleAction($el) { /* toggle state + aria */ }

  $(document).on("click.yourModule", ".your-root .your-trigger", function (e) {
    e.preventDefault();
    handleAction($(this));
  });

  $(document).on("keydown.yourModule", ".your-root .your-trigger", function (e) {
    if (e.key !== "Enter" && e.key !== " ") return;
    e.preventDefault();
    handleAction($(this));
  });
})(jQuery);
```

## Related Project docs

- Layout QC (text only on existing modules): [rewrites.md](/cursor/stores/bc-f811de4f-0251-4ac1-b459-09e239894db9/docs/rewrites.md)
- MAC MARKETLY root: `preferences.md` Park Lex local root entry