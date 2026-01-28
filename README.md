# SleepTracker 🌙

**SleepTracker** is a modern iOS application designed to help users monitor and improve their sleep habits. 

> **Note**: This project marks my **first-ever Swift application**. It was originally developed as a technical test for **Lunabee Studio** (Chambéry). Since then, it has been refactored to showcase modern iOS development practices, including a futuristic "iOS 26" aesthetic.

## 📱 Features

SleepTracker offers a comprehensive suite of tools organized into three main hubs:

### 1. Sleep Goals (Home)
- **Smart Dashboard**: Instantly view your sleep performance from the previous night.
- **Goal Setting**: Intuitively set your ideal bedtime and wake-up time.
- **Insights**: Get simple, actionable feedback on your sleep schedule (e.g., "Not enough sleep" or "Goal met!").

### 2. Device Monitor (Tracker)
- **Active Tracking**: The app monitors your device usage across the ecosystem (iPhone, Mac, Watch) to detect when you are active.
- **Manual Mode**: Large, haptic-enhanced buttons to manually signal when you are going to sleep and waking up.
- **Auto-Deduction**: (Concept) Automatically deducts "active device time" from your total sleep duration to provide a more accurate rest metric.

### 3. Analytics (Stats)
- **Weekly Overview**: Interactive bar charts powered by **Swift Charts** visually display your sleep patterns over the last 7 days.
- **Trend Analysis**: Automatically calculates your weekly average to help you spot trends.

## 🛠 Architecture & Tech Stack

This project is built with **Swift 6** and **SwiftUI**, adhering to a strict **MVVM (Model-View-ViewModel)** architecture to ensure testability and separation of concerns.

- **UI Framework**: SwiftUI (with custom Glassmorphism and Neon design tokens).
- **Data Persistence**: Custom `JSON` Store in the Documents directory for easy debugging and portability.
- **Visualization**: Swift Charts.
- **Compatibility**: iOS 16+ (Optimized for iPhone).

### Project Structure
```
SleepTracker/
├── Models/         # Data structures (SleepSession, SleepSchedule)
├── Views/          # UI Components (Home, Tracker, Stats)
├── ViewModels/     # Business Logic & State Management
└── Services/       # Data Persistence (SleepStore)
```

## 🚀 Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Start-Zero/SleepTracker.git
   ```
2. **Open in Xcode**:
   Double-click `SleepTracker.xcodeproj`.
3. **Build and Run**:
   Select an iOS Simulator (e.g., iPhone 16 Pro) and press `Cmd + R`.

---

*Created by Tom Boullay.*
