# Changelog

## [Unreleased]

### Added
- Full authentication flow with Login and Register screens that gate app content behind auth
- `register(name:email:password:)` API method on `APIServiceProtocol`, `MockAPIService`, and `LiveAPIService`
- `AuthViewModel` with client-side validation (non-empty fields, email format, password match, min 6 characters)
- `LoginView` with email/password fields, branding, error alerts, and navigation to register
- `RegisterView` with name/email/password/confirm fields, branding, error alerts, and back navigation
- `login()` and `logout()` helper methods on `AppState`
- `invalidCredentials` and `emailAlreadyExists` cases to `APIError`

### Changed
- App now starts logged out (`isLoggedIn` defaults to `false`) and shows `LoginView` until authenticated
- `ContentView` conditionally renders `LoginView` or the main `TabView` based on auth state

### Fixed
- Fixed Profile screen not rendering due to non-exhaustive view conditions in `ProfileView`. The `if/else if` chain lacked a final `else` clause, causing an empty view when `isLoading=false`, `error=nil`, and `customer=nil` on initial render. Restructured conditions to always display either profile content, an error view, or a loading indicator.
