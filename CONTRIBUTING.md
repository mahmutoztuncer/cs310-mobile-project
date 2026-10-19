# Contribution workflow

1. Create an issue describing the task, its owner, and completion criteria.
2. Work on a short-lived branch such as `feat/login`, `fix/navigation`, or `docs/proposal`.
3. Make small, clear commits describing the changes.
4. Open a pull request linked to the issue and explain the change and verification.
5. Ask another group member to review before merging into `main`.

Every member should contribute, review the final submission, and understand their own work. Record a different coordinator for each course project step.

## Once Flutter implementation starts

Document the agreed Flutter SDK version and setup commands in the README. Before opening a pull request, run the relevant formatting, analysis, and tests for the change. Commit the application's `pubspec.lock` so the team shares dependency versions.

Never commit API secrets, passwords, signing keys, or local configuration. Use an `.env.example` with placeholder values when configuration instructions are needed.
