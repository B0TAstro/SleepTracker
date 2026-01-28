# SleepTracker 🌙

**SleepTracker** is a modern iOS application designed to help users monitor and improve their sleep habits

> **Note**: This project is my **first-ever Swift application**. It was originally developed as a technical test for **Lunabee Studio** (Chambéry)

## Features

### 1. Sleep Goals (Home)
- **Smart Dashboard**: Instantly view your sleep performance from the previous night
- **Goal Setting**: Intuitively set your ideal bedtime and wake-up time
- **Insights**: Get simple, actionable feedback on your sleep schedule (e.g., "Not enough sleep" or "Goal met!")

### 2. Device Monitor (Tracker)
- **Active Tracking**: The app monitors your device usage across the ecosystem (iPhone, Mac, Watch) to detect when you are active
- **Manual Mode**: Large, haptic-enhanced buttons to manually signal when you are going to sleep and waking up
- **Auto-Deduction**: (Concept) Automatically deducts "active device time" from your total sleep duration to provide a more accurate rest metric

### 3. Analytics (Stats)
- **Weekly Overview**: Interactive bar charts powered by **Swift Charts** visually display your sleep patterns over the last 7 days
- **Trend Analysis**: Automatically calculates your weekly average to help you spot trends

## Architecture 
```
SleepTracker/
├── Models/         # Data structures (SleepSession, SleepSchedule)
├── Views/          # UI Components (Home, Tracker, Stats)
├── ViewModels/     # Business Logic & State Management
└── Services/       # Data Persistence (SleepStore)
```

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/B0TAstro/SleepTracker.git
   ```
2. **Open in Xcode**:
   Double-click `SleepTracker.xcodeproj`
3. **Build and Run**:
   Select an Simulator (e.g., iPhone 16 Pro) and start it !

---

*Created by Tom Boullay*
