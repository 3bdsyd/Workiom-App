# Workiom Test App

A Flutter demo app that implements the **Workiom tenant sign-up flow**:

- Detect current session on launch (splash).
- Guide the user through creating an account, choosing a password, and creating a workspace (tenant).
- Register tenant + authenticate user.
- Persist auth/session info securely on the device.

---

## ⭐ Features

- **Splash flow**
  - Calls `GetCurrentLoginInformations`
  - Navigates to:
    - Sign up (no user & no tenant)
    - Tenant sign-in (tenant only)
    - Home (user & tenant)
    - Tenant selection (user only, no tenant)

- **Sign up by email**
  - Stepper-ish flow:
    - Create account
    - Password
    - Company / workspace info
  - Validates password based on backend `GetPasswordComplexitySetting`
  - Validates:
    - Tenant name: starts with a letter, contains letters / digits / dashes
    - First / last name: letters only
  - Checks tenant availability via `IsTenantAvailable`

- **Tenant registration**
  - Calls `RegisterTenant`
  - Immediately calls `Authenticate` with the new tenant
  - Stores:
    - Access token + encrypted token
    - Refresh token and expiry
    - Current user & tenant info (IDs, names, edition...)

- **Networking**
  - `Dio` + `Retrofit` for API layer
  - Automatic auth header (`Bearer` token)
  - Basic retry for transient errors
  - Connectivity check via `connectivity_plus`

- **State management & navigation**
  - `flutter_bloc` (Cubit)
  - `go_router` for declarative routing
  - `get_it` for dependency injection

- **UI / UX**
  - Responsive layout with `flutter_screenutil`
  - SVG assets via `flutter_svg` & `flutter_gen`
  - Custom buttons, app bars and loaders
  - Optional onboarding / hints via `tutorial_coach_mark`
  - Splash screen & app icon via `flutter_native_splash` & `flutter_launcher_icons`

---

## 🧱 Project structure (high level)

```text
lib/
  core/
    app_theme.dart
    constants.dart
    di/
      service_locator.dart
    helper/
      debug_logger_helper.dart
      time_zone_helper.dart
    network/
      network_info.dart
    gen/           # Generated assets (flutter_gen)
  features/
    auth/
      data/
        auth_api_service.dart
        auth_repository_impl.dart
        models/...
    signup/
      cubit/
        sign_up_cubit.dart
        sign_up_state.dart
      screens/
        create_account_screen.dart
        password_screen.dart
        company_screen.dart
        thank_you_screen.dart
      widgets/...
    splash/
      cubit/
        splash_cubit.dart
        splash_state.dart
      screens/
        splash_screen.dart
    home/
      screens/home_screen.dart
    tenant/
      screens/tenant_sign_in_screen.dart
      screens/tenant_selection_screen.dart
  shared/
    custom_button.dart
    custom_google_button.dart
    custom_appbar.dart
    ...
  router/
    app_router.dart
