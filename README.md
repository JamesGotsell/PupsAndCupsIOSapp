# Pups & Cups - iOS Application

A loyalty and rewards program mobile application for a dog cafe chain.

## Purpose

Pups & Cups enables customers to:
- Register for an account or log in with existing credentials
- Discover and join loyalty programs at participating businesses
- Earn points through purchases at partner locations
- Scan QR codes at physical locations to record transactions
- Track transaction history across all memberships
- Redeem rewards using accumulated points
- Manage their profile and view account stats

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
├── Models/          # Customer, Business, Membership, Transaction, Reward, APIError
├── Services/        # LiveAPIService, MockAPIService, KeychainService
├── ViewModels/      # Auth, MyBusinesses, Discover, BusinessDetail, Scan, Profile, History VMs
├── Views/           # SwiftUI views organized by feature
│   ├── Auth/        # Login and Registration screens
│   ├── Components/  # Reusable UI components (LoadingView, ErrorView, FloatingActionButton)
│   ├── Home/        # Dashboard with memberships and quick scan access
│   ├── Discover/    # Browse and join new loyalty programs
│   ├── Business/    # Business detail, info, history, and rewards
│   ├── Scan/        # QR code scanning
│   ├── Rewards/     # Reward cards and redemption confirmation
│   ├── Profile/     # User profile and account stats
│   └── History/     # Transaction history
└── Utilities/       # Extensions, MockData
```

## Key Features

### Authentication (Login & Registration)
Full authentication flow with dedicated login and registration screens. Includes form validation (email format, password length, password confirmation), loading states, and error handling. Auth state is managed globally via `AppState` — unauthenticated users see the login screen, authenticated users see the main tab interface.

### Tab Navigation
Four main sections: Home, Discover, Activity, and Profile.

### Discover & Join Businesses
Browse and search for participating businesses. View business details including info, rewards, and transaction history. Join new loyalty programs directly from the app.

### QR Code Scanning
Camera integration using AVFoundation with full-screen overlay, guidance UI, and a floating action button for quick access from the Home tab.

### Profile & Stats
View account information, membership stats, and logout. The profile view handles all loading states with proper fallback rendering.

### Secure Authentication
Auth tokens stored securely in iOS Keychain. All authenticated API requests include a Bearer token in the Authorization header.

## Backend API

Connects to `https://api.pupsandcups.com/v1`

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/login` | User login |
| POST | `/auth/register` | User registration |
| POST | `/auth/logout` | User logout |
| GET | `/customer` | Fetch user profile |
| GET | `/memberships` | Fetch user memberships |
| GET | `/businesses?q={query}` | Search businesses |
| GET | `/businesses/{id}` | Get business details |
| POST | `/businesses/{id}/join` | Join a loyalty program |
| GET | `/transactions` | Fetch all transactions |
| GET | `/transactions/recent?limit={n}` | Recent transactions |
| GET | `/transactions?page={p}&pageSize={s}` | Paginated history |
| POST | `/scan` | Submit QR code |
| GET | `/rewards` | List available rewards |
| POST | `/rewards/{id}/redeem` | Redeem a reward |

## Technical Highlights

- **Thread Safety** - `@MainActor` ensures UI updates on main thread
- **Global Auth State** - `AppState` environment object manages authentication and routes between login and main content
- **Testability** - Protocol-based services with MockAPIService for testing/previews
- **Camera Bridge** - UIViewControllerRepresentable for AVFoundation integration
- **Custom Styling** - Extension-based color system (appPrimary, appAccent, appBackground)
- **Error Handling** - Custom APIError enum with localized descriptions (including auth-specific errors like `invalidCredentials` and `emailAlreadyExists`)
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
