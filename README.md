# Qonfi — GTM Web Tag Template

A Google Tag Manager web tag template for [Qonfi](https://getqonfi.com) guided selling widgets. Load the Qonfi script via GTM to enable product recommendation wizards on your website.

## Features

- **Script Loading** — Load the Qonfi wizard script via GTM with consent control
- **Custom dataLayer** — Optionally configure a custom dataLayer variable name for Qonfi events
- **Auto-detection** — Qonfi automatically detects widget elements on your page via MutationObserver
- **DataLayer Events** — Qonfi pushes `qonfi_interaction` events to the dataLayer for GA4 tracking
- **Debug Mode** — Console logging for troubleshooting

## Setup

### 1. Add Widget Elements to Your Site

Add Qonfi widget elements to your page HTML where you want the wizard to appear:

```html
<div data-qonfi-uuid="YOUR-WIDGET-UUID" style="min-height: 286px;"></div>
```

Find your widget UUID in the Qonfi dashboard under **Publish**.

Optional attributes:
- `data-qonfi-view-type` — Display mode: `inline` (default), `popup`, or `sidebar`
- `data-qonfi-lang` — Language override (e.g., `de`, `fr`, `nl`)
- `data-qonfi-currency` — Currency override (e.g., `eur`, `usd`)
- `data-qonfi-product-id` — Product ID for Product Check feature

### 2. Create the GTM Tag

1. In GTM, go to **Templates > Tag Templates > Search Gallery**
2. Search for **Qonfi** (by New North Digital)
3. Add to workspace
4. Create a new tag using the **Qonfi** template
5. Set the trigger to **All Pages**

### 3. Track Qonfi Events in GA4

Qonfi automatically pushes `qonfi_interaction` events to the dataLayer. To forward these to GA4:

1. Create a **Custom Event Trigger** for event name `qonfi_interaction`
2. Create **Data Layer Variables** for the parameters you want to track:
   - `qonfi_id` — Widget UUID
   - `qonfi_name` — Widget name
   - `qonfi_is_start` — Whether user started the wizard
   - `qonfi_is_finish` — Whether user reached the results
   - `qonfi_is_click_through` — Whether user clicked through to a product
   - `qonfi_question` — Question answered
   - `qonfi_answer` — Answer chosen
3. Create a **GA4 Event Tag** with event name `qonfi_interaction` and map the parameters

## Important Note

Qonfi recommends adding the script directly to your website HTML for best performance. When loading via GTM, there may be a slight delay and the widget may not appear in Safari Incognito mode or with Safari Advanced Protection enabled (since GTM itself may be blocked in those cases).

## Template Fields

| Field | Required | Description |
|-------|----------|-------------|
| Custom dataLayer name | No | Override the default dataLayer name (leave empty for standard `dataLayer`) |

## Permissions

- **Inject Scripts** — Loads `https://platform.getqonfi.com/build-wizard3/wizard3.js`
- **Access Global Variables** — Write `window.qonfiDataLayer` (only when custom name is set)
- **Logging** — Console logging in debug/preview mode only

## Resources

- [Qonfi Documentation](https://getqonfi.com/documentation)
- [How to Publish Qonfi](https://getqonfi.com/documentation/how-to-s/publish)
- [Tracking Qonfi Events in GA4](https://getqonfi.com/documentation/analyzing-and-optimizing-your-selling-guide/tracking-qonfi-events-in-ga4-google-analytics-4)

## Author

Created by [New North Digital](https://newnorth.digital?utm_source=github&utm_medium=gtm-template&utm_campaign=qonfi-web-tag)

## License

Apache 2.0 — see [LICENSE](LICENSE).
