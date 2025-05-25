# Quick Tap Game (Flutter APP)

A lightning‑fast reflex game built with Flutter. Tap the moving circle as many times as you can before the 30‑second timer hits zero.

---

## �️ Demo

| Gameplay                     | Game Over             |
| ---------------------------- | --------------------- |
| *Add GIF or screenshot here* | *Add screenshot here* |

---

## ✨ Features

* **Single‑screen, instant fun** – no menus, no load times.
* **Material 3 design** – smooth colours, rounded corners, subtle shadows.
* **Adaptive layout** – scales to phones, tablets and desktop.
* **Score & timer chips** – live HUD updates every second.
* **Scale animation** on tap for tactile feedback.
* **Replay in one tap** – restart without navigating away.

---

## 🚀 Tech Stack

| Layer | Library / Tool                           |
| ----- | ---------------------------------------- |
| UI    | Flutter 3 (Material 3)                   |
| State | `StatefulWidget` + `Timer`               |
| Anim. | `AnimationController`, `ScaleTransition` |
| Logic | Pure Dart (no third‑party packages)      |

---

## 📂 Project Structure

```
quick_tap_game/
├─ lib/
│  └─ main.dart        # Entire game logic & UI
├─ assets/             # (Optional) SFX / images
└─ README.md           # This file
```

---

## 🛠️ Getting Started

### Prerequisites

* Flutter 3.19 or newer
* Dart 3.

### Installation

```bash
# 1. Clone the repo
$ git clone https://github.com/bektas-sari/quick_tap_game.git
$ cd quick_tap_game

# 2. Fetch dependencies (none besides Flutter SDK)
$ flutter pub get

# 3. Run
$ flutter run        # choose a device/emulator when prompted
```

### Customising

| Parameter         | Location    | What it does                   |
| ----------------- | ----------- | ------------------------------ |
| `gameDuration`    | `main.dart` | Total game time (default 30 s) |
| `circleDiameter`  | `main.dart` | Circle size (default 80 px)    |
| `colorSchemeSeed` | `ThemeData` | Primary colour seed            |

---

## 🤝 Contributing

Pull requests are welcome! If you spot a bug or have an improvement idea, please open an issue first to discuss what you would like to change.

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 👤 Developer

**Bektas Sari**
Email: [bektas.sari@gmail.com](mailto:bektas.sari@gmail.com)  <br>
GitHub: [https://github.com/bektas-sari](https://github.com/bektas-sari) <br>
LinkedIn: [www.linkedin.com/in/bektas-sari](http://www.linkedin.com/in/bektas-sari) <br>
Researchgate: [https://www.researchgate.net/profile/Bektas-Sari-3](https://www.researchgate.net/profile/Bektas-Sari-3) <br>
Academia: [https://independent.academia.edu/bektassari](https://independent.academia.edu/bektassari) <br>

---

*Made with ♥ and plenty of caffeine.*
