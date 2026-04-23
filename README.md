# N50 — Interactive Quiz Application

A Russian-language, mobile-first multi-page interactive quiz delivered as static HTML.
Each page presents a distinct interaction (name selection, multiple choice, number entry, toy matching),
with responses collected via Formspree.

---

## Pages

| File | Purpose |
|------|---------|
| `start.html` | Welcome screen with looping video background |
| `page1.html` | Name selection — checkboxes + free-text fallback |
| `page2.html` | Multiple-choice question about Adolf Szabad |
| `page3.html` | Animated stork identification and naming |
| `page4.html` | Three two-digit number guessing game |
| `page5.html` | 2×2 toy-matching quiz |
| `template.html` | Development reference — not part of the user flow |

Navigation is linear: each page resolves adjacent files via a `HEAD` fetch and enables
Back / Forward buttons only when those files exist.

---

## Layout Constraints

- **Viewport:** mobile-first, 9:16 portrait ratio
- **Page width:** `min(calc(100vh × 9/16), 430px, 100vw)` — scales with viewport height, caps at 430 px
- **Min height:** `100vh`
- **Padding:** `32px 24px 40px` (top / horizontal / bottom); pages with full-bleed images use `0 24px 40px`
- **Full-bleed images:** `width: calc(100% + 48px); margin-left: -24px` — images extend to the page edge, overriding horizontal padding
- **Body:** `display: flex; justify-content: center` — centres the page frame on larger screens

---

## Colour Palette

### Background colours

| Role | Hex | RGB |
|------|-----|-----|
| Page background (parchment) | `#ede8df` | `rgb(237, 232, 223)` |
| Body surround (espresso) | `#1a0e06` | `rgb(26, 14, 6)` |
| Form field background | `#f7f3ec` | `rgb(247, 243, 236)` |
| Checked choice background | `#f0e8e0` | `rgb(240, 232, 224)` |

### Interactive / accent colours

| Role | Hex | RGB |
|------|-----|-----|
| Primary action (maroon) | `#8b1a1a` | `rgb(139, 26, 26)` |
| Active / pressed state | `#6e1515` | `rgb(110, 21, 21)` |
| Disabled button | `#c4b8ae` | `rgb(196, 184, 174)` |

### Text colours

| Role | Hex | RGB |
|------|-----|-----|
| Primary text | `#2c1810` | `rgb(44, 24, 16)` |
| Button / label text | `#faf7f2` | `rgb(250, 247, 242)` |
| Placeholder / secondary | `#9a8c82` | `rgb(154, 140, 130)` |
| Borders / rules | `#c8bfb0` | `rgb(200, 191, 176)` |

---

## Typography

| Stack | Usage |
|-------|-------|
| `Georgia, 'Times New Roman', serif` | Body / page text |
| `'Segoe UI', Roboto, Helvetica, Arial, sans-serif` | Form inputs, labels, UI numbers |

Font sizes: 12–20 px. Font weights: 400 (body), 600–700 (labels/buttons), 900 (grid numbers).
Button letter-spacing: `0.14em`.

---

## Shared Stylesheet — `buttons.css`

Covers all interactive controls used across every page:

- `#nav` — flex navigation bar, `gap: 10px`, pinned to bottom via `margin-top: auto`
- `.btn` — Back / Forward navigation buttons (maroon fill, 17 px padding, 0.15 s transition)
- `#btn-submit` — outline-style submit button (transparent background, maroon border/text)
- Disabled and active states for both button types

---

## Form Submissions

All forms `POST` to [Formspree](https://formspree.io) with `Accept: application/json`.
The submit button shows `…` while in flight, then `✓ ОТПРАВЛЕНО` on success.

| Page | Endpoint | Key fields |
|------|----------|-----------|
| page1 | `mvzdbzyr`→`meevgjbz` | `name` (multi-checkbox), `custom_name` |
| page2 | `mlgabdwv` | `answer` (radio) |
| page3 | `xpqkrkyq` | `stork1_num`, `stork2_num`, `stork3_num`, `stork2_name`, `stork3_name` |
| page4 | `xwvabybp` | `nikita`, `petya`, `krash` (integers 10–99) |
| page5 | `mvzdbzyr` | `toy1_guess`–`toy4_guess` (integers 1–4); submits `CORRECT` or the guess sequence |

---

## Assets

```
assets/
  Video_Background_Color_Changed.mp4   start.html background video
  Bear_Greeting_Video.mp4              present in repo, not currently used
  name_select.jpg                      page1 photo overlay
  adolf_szabad.jpg                     page2 context image
  adolf_szabad_txt.jpg                 page2 text hint
  storck1–3.jpg                        page3 animated stork images
  mkl_facebook.jpg                     page4 hero image
  toy1–4.jpg                           page5 2×2 quiz grid
```

---

## Key Implementation Notes

- Images that bleed to the page edge use negative left margin to cancel padding; their container keeps `overflow: hidden`.
- The page5 photo grid uses `aspect-ratio: 1` on `.photo-grid` with `grid-template-rows: 1fr 1fr` to enforce equal square cells regardless of source image proportions. Each image is `position: absolute; object-fit: cover`; `toy2.jpg` additionally uses `object-position: top` to keep the subject's head in frame.
- Navigation buttons are rendered but hidden/disabled on load; JavaScript enables them only after confirming the target file exists.
- Number inputs on page5 are restricted to digits 1–4 via a `keydown` guard; the `<input type="number">` spinner is hidden with `-webkit-appearance: none` / `-moz-appearance: textfield`.
