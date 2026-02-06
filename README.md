# Pups & Cups - iOS Application

A loyalty and rewards program mobile application for a dog cafe chain.

## Purpose

Pups & Cups enables customers to:
- Earn points through purchases at Pups & Cups locations
- Scan QR codes at physical locations to record transactions
- Track transaction history
- Redeem rewards using accumulated points
- Progress through membership tiers (Bronze → Silver → Gold → Platinum)

## Architecture

| Aspect | Technology |
|--------|------------|
| **Pattern** | MVVM (Model-View-ViewModel) with Clean Architecture |
| **UI Framework** | Pure SwiftUI (modern declarative approach) |
| **Concurrency** | Async/await throughout |
| **Dependencies** | None - uses only Apple native frameworks |

## Project Structure

```
PupsAndCups/
├── Models/          # Customer, Transaction, Reward, APIError
├── Services/        # LiveAPIService, MockAPIService, KeychainService
├── ViewModels/      # Home, Scan, Rewards, Profile, History VMs
├── Views/           # SwiftUI views organized by feature
│   ├── Components/  # Reusable UI components
│   ├── Home/        # Dashboard with balance and recent activity
│   ├── Scan/        # QR code scanning
│   ├── Rewards/     # Reward catalog and redemption
│   ├── Profile/     # User profile and tier progress
│   └── History/     # Paginated transaction history
└── Utilities/       # Extensions, MockData
```

## Key Features

### Tab Navigation
Four main sections: Home, Rewards, History, and Profile.

### QR Code Scanning
Camera integration using AVFoundation with full-screen overlay and guidance UI.

### Tier System
Visual progress tracking with color-coded badges:
- **Bronze** - 0 points
- **Silver** - 500 points
- **Gold** - 1,500 points
- **Platinum** - 5,000 points

### Infinite Scroll
Paginated transaction history with lazy loading (20 items per page).

### Pull-to-Refresh
Available on Home, Rewards, and History screens.

### Secure Authentication
Tokens stored securely in iOS Keychain.

## Backend API

Connects to `https://api.pupsandcups.com/v1`

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/login` | User authentication |
| GET | `/customer` | Fetch user profile |
| GET | `/transactions/recent?limit={n}` | Recent transactions |
| GET | `/transactions?page={p}&pageSize={s}` | Paginated history |
| POST | `/scan` | Submit QR code |
| GET | `/rewards` | List available rewards |
| POST | `/rewards/{id}/redeem` | Redeem a reward |
| POST | `/auth/logout` | User logout |

## Technical Highlights

- **Thread Safety** - `@MainActor` ensures UI updates on main thread
- **Testability** - Protocol-based services with MockAPIService for testing/previews
- **Camera Bridge** - UIViewControllerRepresentable for AVFoundation integration
- **Custom Styling** - Extension-based color system (appPrimary, appAccent, appBackground)
- **Error Handling** - Custom APIError enum with localized descriptions and retry functionality
- **State Management** - @Published, @StateObject, and @EnvironmentObject for reactivity

## Frameworks Used

- **SwiftUI** - Declarative UI framework
- **AVFoundation** - Camera access and QR code scanning
- **Foundation** - Async/await, JSON Codable
- **Security** - Keychain services for token storage
- **UIKit** - Limited integration for QRScannerViewController

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
