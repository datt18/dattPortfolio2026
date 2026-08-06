# 🚀 Datt Patel — iOS & Flutter Developer Portfolio

> A premium, Apple-inspired Flutter portfolio website built with MVVM architecture, Riverpod state management, GoRouter, and Flutter Animate.

---

## ✨ Features

- **Apple-Inspired Design** — Dark glassmorphism UI with Apple accent colors
- **Animated Hero Section** — Typing animation, floating tech icons, particle background
- **Project Showcase** — Filterable project cards with hover animations
- **Skills Section** — Animated progress bars with category filtering
- **About + Experience Timeline** — Stat counters, story card, experience timeline
- **Services Grid** — 6 animated service cards
- **Certificates Timeline** — Achieved/In-Progress/Planned status badges
- **Contact Form** — `mailto:` powered form with success state
- **Dark/Light Theme** — Full system-aware theme toggle
- **Floating Navigation** — Pill nav that appears after scrolling
- **Scroll Progress Bar** — Gradient progress indicator
- **Loading Screen** — Pulsing logo loader with progress
- **404 Page** — Animated not-found screen
- **SEO Ready** — `web/index.html` with full meta tags, OG, Twitter Card
- **Responsive** — Mobile, Tablet, Desktop optimized

---

## 🛠 Tech Stack

| Category | Package |
|---|---|
| State Management | `flutter_riverpod ^2.6.1` |
| Routing | `go_router ^14.6.2` |
| Animations | `flutter_animate ^4.5.0` |
| Fonts | `google_fonts ^6.2.1` |
| Icons | `font_awesome_flutter ^10.8.0` |
| URL Handling | `url_launcher ^6.3.1` |
| Responsive | `responsive_framework ^1.5.1` |
| Visibility | `visibility_detector ^0.4.0+2` |

---

## 📁 Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       ← Color palette
│   │   ├── app_strings.dart      ← ✏️ Edit your personal info here
│   │   └── app_dimensions.dart   ← Spacing tokens
│   ├── theme/
│   │   ├── app_theme.dart        ← Dark & Light themes
│   │   └── text_styles.dart      ← Typography system
│   ├── models/
│   │   ├── project_model.dart
│   │   ├── skill_model.dart
│   │   ├── experience_model.dart
│   │   └── certificate_model.dart
│   ├── providers/
│   │   ├── theme_provider.dart
│   │   ├── portfolio_provider.dart  ← ✏️ Update your projects/skills here
│   │   └── scroll_provider.dart
│   └── utils/
│       └── responsive_utils.dart
├── widgets/
│   ├── glass_card.dart
│   ├── gradient_button.dart
│   ├── section_header.dart
│   ├── animated_counter.dart
│   ├── typing_text.dart
│   ├── skill_chip.dart
│   ├── project_card.dart
│   ├── nav_bar.dart
│   ├── floating_nav.dart
│   ├── scroll_progress_bar.dart
│   ├── loading_screen.dart
│   ├── particle_background.dart
│   └── social_icon_button.dart
├── screens/
│   ├── home/
│   │   ├── hero_section.dart
│   │   ├── about_section.dart
│   │   ├── skills_section.dart
│   │   ├── projects_section.dart
│   │   ├── services_section.dart
│   │   ├── certificates_section.dart
│   │   ├── contact_section.dart
│   │   └── footer_section.dart
│   ├── portfolio_screen.dart
│   └── not_found_screen.dart
└── main.dart
assets/
├── images/          ← Add profile.jpg here
├── icons/
└── fonts/           ← Optional SF Pro fonts
```

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run development server (web)
flutter run -d chrome

# Build for production
flutter build web --release --web-renderer html

# Serve locally
cd build/web && python3 -m http.server 8080
```

---

## ✏️ Customization

### 1. Personal Information
Edit `lib/core/constants/app_strings.dart`:
```dart
static const String email = 'your@email.com';
static const String phone = '+91 XXXXX XXXXX';
static const String github = 'https://github.com/yourusername';
static const String linkedin = 'https://linkedin.com/in/yourusername';
static const String resumeUrl = 'https://link-to-your-resume.pdf';
```

### 2. Projects
Edit `lib/core/providers/portfolio_provider.dart` → `_projects` list.

### 3. Skills
Edit `lib/core/providers/portfolio_provider.dart` → `_skills` list.

### 4. Experience
Edit `lib/core/providers/portfolio_provider.dart` → `_experiences` list.

### 5. Profile Photo
Drop your photo as `assets/images/profile.jpg`, then in `hero_section.dart` replace `_buildProfileImage()` with:
```dart
Image.asset('assets/images/profile.jpg', fit: BoxFit.cover)
```

---

## 🎨 Color Palette

| Token | Color | Hex |
|---|---|---|
| Primary BG | ![#09090B](https://via.placeholder.com/12/09090B/000000?text=+) | `#09090B` |
| Apple Blue | ![#007AFF](https://via.placeholder.com/12/007AFF/000000?text=+) | `#007AFF` |
| Apple Purple | ![#AF52DE](https://via.placeholder.com/12/AF52DE/000000?text=+) | `#AF52DE` |
| Apple Green | ![#34C759](https://via.placeholder.com/12/34C759/000000?text=+) | `#34C759` |
| Apple Orange | ![#FF9F0A](https://via.placeholder.com/12/FF9F0A/000000?text=+) | `#FF9F0A` |

---

## 📜 License

MIT — Feel free to use as a template.

---

*Made with Flutter ❤️ by Datt Patel*
