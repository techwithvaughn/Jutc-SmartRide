# JUTC SmartRide

A production-ready Flutter and Web implementation of Jamaica's JUTC (Jamaica Urban Transit Company) transit information app, with Material Design 3, local storage, PDF schedules, and intelligent age-based user profiling.

## Features

### 🚌 Route Search & Filtering
- Search by route number, origin, or destination
- Filter by route type (Standard, Premium, Express, Rural)
- View detailed route information
- Save favorite routes for quick access

### 📄 In-App PDF Schedules
- View JUTC route schedules directly in the app using embedded PDF viewer
- Pinch-to-zoom for better readability
- Fallback to external browser if PDF fails to load in-app
- All 164+ JUTC routes supported with official PDF links

### 👤 Age-Based User Profiles
- **Startup process**: Asks for user name, birth year, and birth month (optional)
- **Smart detection**: Automatically determines if user is child (< 18) or adult (≥ 18)
- **Child vs Adult cards**: Shows different SmartFare card designs based on age
- **Persistent storage**: Profiles saved locally via LocalStorage (Web) or Hive (Flutter)

### 🗺️ Bus Tracking
- Map view with demo bus marker
- Location services (location requested on-demand)
- Quick access to bus schedules from the map

### 🎨 Material Design 3
- Dark and light theme modes
- Bouncy animations throughout
- Responsive design for mobile and web
- Expressive motion and smooth transitions

### ⚙️ Settings
- Theme preferences (Dark/Light)
- Motion preferences
- Text size adjustments
- User profile management

## Setup

### Web (HTML)

The web version is a single HTML file located at `web/jutc.html`:

```bash
# Serve locally (Python 3)
python3 -m http.server 8000 --directory web

# Or use any web server and navigate to jutc.html
```

**Features in HTML:**
- Startup modal with age detection
- In-app PDF viewer using iframes
- Persistent user profiles via localStorage
- 164+ JUTC routes with real PDF links
- Full Material Design UI

### Flutter

```bash
flutter pub get
```

#### Run (Android)
```bash
flutter run
```

#### Run (iOS)
```bash
cd ios
pod install
cd ..
flutter run
```

#### Run (Web)
```bash
flutter run -d web
```

## Architecture

### Flutter Project Structure
```
lib/
  main.dart                # App entry point with Material 3 theme
  jutc_home.dart          # Main UI and navigation
  jutc_data.dart          # Route data constants

pubspec.yaml              # Dependencies including:
  - google_fonts: Typography
  - pdfx: PDF viewing
  - animations: Smooth transitions
```

### Flutter Dependencies
- `flutter`: SDK with Material Design 3 support
- `google_fonts`: Beautiful typography (Outfit font)
- `pdfx`: In-app PDF viewer with pinch-to-zoom
- `animations`: Material 3 expressive motion package
- `font_awesome_flutter`: Additional icons

## PDF Schedule Viewing

### How It Works

1. **User taps "View Schedule"** on a route card
2. **App loads PDF** using the `pdfx` package (Flutter) or iframe (Web)
3. **Controls available:**
   - Full-screen viewing
   - Pinch-to-zoom (Flutter)
   - Back button to return to routes
4. **Fallback option:** If PDF fails to load, user can open in new tab/external app

### Supported Routes

All 164+ JUTC routes have official PDF schedule links from `jutc.gov.jm`:

- **Standard routes** (1-99): Urban transit within Kingston metro area
- **Premium routes** (101-399): Express and premium services
- **Express/Rural routes** (400+): Long-distance and suburban routes

### Example PDF URLs

```
https://jutc.gov.jm/bus-route-info/timetables/Schedule_610.pdf
https://jutc.gov.jm/bus-route-info/timetables/PREMIUM_SCHEDULE.pdf
```

## User Profiling System

### Startup Process

**First Launch Experience:**
1. User sees welcome modal
2. Enters name (required)
3. Selects birth year (required)
4. Optionally selects birth month

### Age Detection

```
Age = Current Year - Birth Year

If Age < 18 → Child profile
If Age ≥ 18 → Adult profile
```

### Profile Storage

**Web (HTML):**
```javascript
localStorage.setItem('jutcProfile', JSON.stringify({
  name: 'John Doe',
  birthYear: 2010,
  birthMonth: 5,
  age: 14,
  type: 'child'
}))
```

**Flutter:**
Uses local storage (can be integrated with Hive)

### Personalization

**Child Card:**
- Avatar: 👧
- Card color: Blue gradient
- Message: "Special fares for children 12 and under"

**Adult Card:**
- Avatar: 👨
- Card color: Green gradient
- Message: "Unlimited travel on all JUTC routes"

## Search & Filter

### Real-time Search
- Type route number: "610", "20A", "101"
- Type location: "Downtown", "Half Way Tree", "Portmore"
- Filters by origin and destination automatically

### Filter Options
- **All**: Show all routes
- **Standard**: Routes 1-99
- **Premium**: Routes 100-399
- **Rural/Express**: Routes 400+

## Theme System

### Dark Mode (Default)
- Background: #070C15 (very dark blue)
- Surface: #0B1220 (dark blue)
- Primary: #1B7D3A (Jamaica green)
- Secondary: #FFD43B (Jamaica gold/yellow)

### Light Mode
- Background: #FFF7CC (warm cream)
- Surface: #FFFEF6 (off-white)
- Primary: #166A31 (darker green)

## Animations

### Bouncy Animations ✨
- **Nav transitions**: Scale and fade on tab changes
- **Page transitions**: Smooth scale animations
- **Button feedback**: Hover and press effects
- **Search results**: Slide and fade effects

### Easing Functions
```css
--ease-out: cubic-bezier(.2,.8,.2,1);
--ease-bounce: cubic-bezier(.2,1.4,.2,1);
```

## Data

### Route Data Format

```json
{
  "route": "610",
  "origin": "Ocho Rios",
  "destination": "City",
  "via": "North-South Highway",
  "type": "standard",
  "pdf": "https://jutc.gov.jm/bus-route-info/timetables/Schedule_610.pdf"
}
```

### Total Routes
- **164+ routes** covering all JUTC services
- All routes include official PDF links
- Regularly updated from JUTC official source

## Browser Support

| Browser | Support |
|---------|---------|
| Chrome | ✅ Full support |
| Firefox | ✅ Full support |
| Safari | ✅ Full support |
| Edge | ✅ Full support |
| Mobile Safari | ✅ Full support |
| Chrome Mobile | ✅ Full support |

## Mobile App Support

| Platform | Status |
|----------|--------|
| Android | ✅ Fully supported |
| iOS | ✅ Fully supported |
| Web | ✅ Fully responsive |

## Getting Started Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3 Guide](https://m3.material.io/)
- [JUTC Official Site](https://www.jutc.gov.jm/)

## License

This project is created as a transit information tool for Jamaica's JUTC services.

## Support & Feedback

For issues, suggestions, or feedback:
1. Open an issue on GitHub
2. Include details about the route or feature
3. Specify if it's about Web (HTML) or Flutter version

---

**Last Updated:** 2024
**Maintained by:** JUTC SmartRide Team
**Version:** 1.0.0
