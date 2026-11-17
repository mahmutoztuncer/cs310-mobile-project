# CoSUtudy

**Find study partners and project teammates on your campus.**

CS310 Mobile Application Development · Sabancı University · Group 36

CoSUtudy brings campus study sessions and course project announcements into one place. Students can search by course code, filter by announcement type, view details, and find others to work with.

[Design in Figma](https://www.figma.com/design/TpMqaWalOgwPitaN44QkOc/CS310?node-id=0-1) · [Development branches](https://github.com/mahmutoztuncer/cs310-mobile-project/branches) · [Contribution workflow](CONTRIBUTING.md)

## Current development

**Step 2 — Flutter UI and navigation.** Implementation is progressing on feature branches. As of 18 November 2026, `main` contains the project documentation. The Flutter application is available on the branches below.

| Branch | Available work |
| --- | --- |
| [`feat/project-setup`](https://github.com/mahmutoztuncer/cs310-mobile-project/tree/feat/project-setup) | Flutter Android/iOS scaffold, announcement model and sample data, shared styling, named routes, bottom navigation, and screen placeholders |
| [`feat/home`](https://github.com/mahmutoztuncer/cs310-mobile-project/tree/feat/home) | Home list, course-code search, announcement-type filters, reusable announcement cards, and light/dark theme toggle |
| [`feat/create-announcement`](https://github.com/mahmutoztuncer/cs310-mobile-project/tree/feat/create-announcement) | Announcement form, input validation, type selection, date/time fields, and creation using in-memory sample data |
| [`feat/gence-auth-profile`](https://github.com/mahmutoztuncer/cs310-mobile-project/tree/feat/gence-auth-profile) | Login, Sign Up, Profile, account validation, password visibility, profile activity navigation, and account-flow tests, built on the Home branch |

The account screens demonstrate validation and navigation with in-memory demo data. Firebase Authentication and Cloud Firestore are planned for backend integration. The Details and My Announcements screens remain placeholders in the inspected account branch. Feature work is integrated through pull requests.

## App experience

| Screen | Purpose |
| --- | --- |
| Log In / Sign Up | Enter university account details and access the app |
| Home | Browse announcements and filter by course code or type |
| Announcement Details | View session or project information, participants, and available places, then join or leave |
| Create Announcement | Enter a study session or project team request with a title, course, description, and capacity |
| My Announcements | View created and joined announcements and manage owned posts |
| Profile | View account information and access announcement activity |

Study sessions also include a meeting location, date, and time. The intended participation flow supports direct joining and leaving, capacity limits, and closing or deleting owned announcements. These flows describe the application scope, with implementation status shown in the branch table above.

## Run the Flutter UI

The commands below check out the account/profile branch so the app opens at Log In. This branch also contains the Home UI. To inspect the creation form implementation, switch to `feat/create-announcement`.

### Requirements

- Flutter SDK whose bundled Dart version satisfies `^3.13.5`, as declared in the application branches' `pubspec.yaml`.
- Android Studio or Xcode with an emulator/simulator, or a connected supported device. Building for iOS requires macOS and Xcode.
- Git.

```bash
git clone --branch feat/gence-auth-profile https://github.com/mahmutoztuncer/cs310-mobile-project.git
cd cs310-mobile-project
flutter --version
flutter doctor
flutter pub get
flutter devices
flutter run
```

At the demo login screen, enter an email ending in `@sabanciuniv.edu` and a non-empty password. Login validates the fields and opens the main navigation. Sign Up additionally validates a full name, a numeric student ID, a password of at least six characters, and password confirmation. Demo account data resets when the app restarts.

### Check changes

Run these commands from a Flutter branch after installing dependencies.

```bash
flutter analyze
flutter test
```

The account branch includes tests for form validation, login navigation, sign-up/profile/logout flow, and a narrow dark layout.

## Code organization

The Flutter branches use the following structure. Individual branches add the screens, widgets, and tests they implement.

```text
lib/
  main.dart          Application entry point and theme
  routes.dart        Named routes
  models/            Announcement model and sample data
  screens/           App screens and bottom-navigation shell
  utils/             Shared colors, text styles, spacing, and helpers
  widgets/           Reusable UI components
test/                Flutter tests
android/             Android project
ios/                 iOS project
```

## Team and responsibilities

The Step 2 coordinator is Ceylin Zeynep Yüksel. The responsibilities below follow the team's Step 2 allocation.

| Member | Design and implementation responsibilities |
| --- | --- |
| Ceylin Zeynep Yüksel | Home wireframe, announcement list and filters, `AnnouncementCard`, team coordination, TA communication, and combined submissions |
| Kerem Mısırlıoğlu | Details and My Announcements wireframes, join/leave interaction, tabs, and removal actions |
| Mahmut Öztunçer | Navigation flow diagram, shared theme and font setup, routes and bottom navigation, announcement model and placeholder data, README, and overflow/responsiveness checks |
| Ilgın Emci | Create Announcement wireframe and form, type selection, inline validation, and confirmation dialog |
| Gence Genceli | Login, Sign Up, and Profile wireframes and UI |

## Planned backend

Firebase Authentication is planned for email/password accounts, and Cloud Firestore for users, announcements, and participation. The planned user record contains a user ID, name, student ID, and university email. Announcement records contain ownership, type, course code, content, capacity, status, and creation time, with location/date/time for study sessions. Participation associates users with announcements.

Implementation will need to handle simultaneous joins, duplicate participation, capacity limits, ownership permissions, validation, and failed requests. Password handling belongs to Firebase Authentication. Student IDs are intended for registration data.

## Project documents

- [Figma wireframes and navigation design](https://www.figma.com/design/TpMqaWalOgwPitaN44QkOc/CS310?node-id=0-1)
- [Step 1 project plan and checklist](PROJECT_PLAN.md)
- [Contribution and pull request workflow](CONTRIBUTING.md)

The project plan records the earlier proposal stage. The development section of this README tracks the current branch-based UI work.
