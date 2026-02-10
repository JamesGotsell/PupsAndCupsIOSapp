# Changelog

## [Unreleased]

### Fixed
- Fixed Profile screen not rendering due to non-exhaustive view conditions in `ProfileView`. The `if/else if` chain lacked a final `else` clause, causing an empty view when `isLoading=false`, `error=nil`, and `customer=nil` on initial render. Restructured conditions to always display either profile content, an error view, or a loading indicator.
