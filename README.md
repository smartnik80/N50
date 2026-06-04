# N50

A Russian-language, mobile-first static web app built for a 50th birthday celebration in Göreme, Cappadocia. Delivered as plain HTML/CSS/JS — no build step, no server required. Works locally via `file://` or hosted on GitHub Pages at `https://smartnik80.github.io/N50/`.

---

## Sections

### Landing — `index.html`

Entry point. Shows a headline photo and five navigation buttons:

| Button | Destination |
|--------|-------------|
| КТО ЗДЕСЬ | `rolodex.html` |
| ВИКТОРИНА | `page1.html` |
| УГАДАЙ КТО | `guesswho.html` |
| ГАЛЕРЕЯ | `gallery.html` |
| МЕНЮ | `menu.html` |

---

### Rolodex — `rolodex.html`

Guest list. Displays a card for each attendee with their photo and name, loaded from `assets/guests/`.

---

### Викторина (Quiz) — `page1.html` … `page13.html`

A 13-question linear quiz about the birthday person. Each page is self-contained and presents a distinct interaction type:

| Pages | Interaction |
|-------|-------------|
| page1 | Name stork identification — three overlapping images, tap to reveal choices |
| page2 | Name selection — checkboxes for each attendee |
| page3 | Multiple choice — photo of Adolf Szabad |
| page4 | Animated image reveal — tongue-in/out photo sequence |
| page5 | Multiple choice with photo |
| page6 | Multiple choice with photo |
| page7 | Multiple choice with photo |
| page8 | Multiple choice with photo (Lodina family) |
| page9 | 2×2 toy-matching grid — number inputs, order the toys |
| page10 | Multiple choice with photo (MKL Facebook) |
| page11 | Multiple choice with full-width photo |
| page12 | Multiple choice |
| page13 | Multiple choice |

Navigation is linear. НАЗАД / ВПЕРЕД buttons are enabled based on page number (back if `n > 1`, forward if `n < 13`). Form submissions are accepted silently — no data is sent anywhere.

---

### Угадай кто (Guess Who) — `guesswho.html`

Photo guessing game. Shows cropped or obscured portraits from `assets/guesswho/` and asks players to identify the person.

---

### Галерея (Gallery) — `gallery.html`

Photo gallery. Loads 191 images from `assets/gallery/`.

---

### Меню (Restaurant Menu) — `menu.html`

Navigation page linking to the four restaurant menus, in chronological order:

| Restaurant | Meal | Date |
|------------|------|------|
| Happena Cappadocia | Ужин | 14 мая |
| Turkish Ravioli | Обед | 15 мая |
| Olivia Cave | Ужин | 15 мая |
| Helke | Ужин | 16 мая |

Each restaurant page (`happena.html`, `ravioli.html`, `oliviacave.html`, `helke.html`) renders a full menu with sections and dishes. Olivia Cave additionally lets guests select their main course.

---

## Assets

```
assets/
  glava-L.jpg                     Headline photo on the landing page
  Bear_Greeting_Video.mp4         Not currently referenced
  Video_Background_Color_Changed.mp4  Not currently referenced

  gallery/        191 photos — loaded by gallery.html
  guesswho/        38 photos — loaded by guesswho.html
  guests/          24 guest profile photos — loaded by rolodex.html
  victorina/       Images and videos for the quiz pages (page1–page13)
  circles/         Per-person video clips used by the (now removed) roulette page
```

---

## Shared Stylesheet — `buttons.css`

Provides the НАЗАД / ВПЕРЕД navigation buttons and the ОТПРАВИТЬ submit button used across all quiz pages.

---

## Layout

All pages use the same mobile-first card layout:

- **Width:** `min(calc(100vh × 9/16), 430px, 100vw)` — portrait 9:16, max 430 px
- **Background:** parchment `#ede8df` on espresso surround `#1a0e06`
- **Full-bleed images:** `width: calc(100% + 48px); margin-left: -24px`

---

## Running Locally

Open `index.html` directly in a browser, or serve with:

```bash
python3 -m http.server 8000
```

then visit `http://localhost:8000`.
