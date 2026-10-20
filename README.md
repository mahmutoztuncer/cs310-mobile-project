# CoSUtudy

**CS310 Mobile Application Development | Group 36**

CoSUtudy is a planned Flutter mobile application that helps students on the same university campus find study partners or form a team for a course project.

Students often share these requests in messaging groups, where announcements can be hard to find or may no longer be available. CoSUtudy brings them together in one place, with course-based filtering and a simple join and leave process.

## Project status

**Step 1: proposal and repository setup.** Application implementation has not started. The scope below follows the group's current project proposal.

## Target users and example use

University students looking for study partners or additional project teammates.

- A student creates a CS310 project announcement seeking two teammates.
- Another student organizes a study session in the library, specifying the course, location, date, time, and capacity.
- Students browse announcements, filter them by course code and type, and join when a place is available.

## Core features

1. **Account registration and login:** Register with a name, student ID, university email address, and password, then sign in.
2. **Create announcements:** Choose a study session or project team announcement and enter the course code, title, description, and available places. The description lets students explain what they need. Study sessions also include a meeting location, date, and time.
3. **Browse and filter:** View announcements, open their details, and filter by course code and announcement type.
4. **Join and leave:** Join an open announcement when space is available and leave it later. Details show participants' names and remaining places.
5. **Manage participation:** View created and joined announcements. Owners can delete or close their own announcements. Closed announcements do not accept new participants.

Both announcement types use the same direct join and leave process.

## Optional features and scope

Announcement editing may be added if the core features are completed on time.

The first version focuses on one campus. In-app chat, notifications, calendar integration, automatic matching, and application approval workflows are outside the planned scope. Participants arrange further communication through their existing channels.

## Planned technology and data

- **Mobile application:** Flutter.
- **Authentication:** Firebase Authentication for email and password login.
- **Shared data:** Cloud Firestore.
- **External APIs:** No additional external API is required for the planned features.

| Data | Planned fields |
| --- | --- |
| Users | User ID, name, student ID, university email address |
| Announcements | Announcement ID, owner ID, type, course code, title, description, capacity, creation time, open or closed status |
| Study session details | Meeting location, date, and time |
| Participation | The user IDs associated with each announcement |

Firebase Authentication will handle passwords; application database records will not store passwords. Student IDs are registration data and are not intended to appear in public announcement participant lists.

## Anticipated challenges

- Keep participation consistent when students join simultaneously and prevent capacity from being exceeded.
- Prevent duplicate participation.
- Allow owners to manage only their own announcements and users to manage only their own participation.
- Validate inputs, refresh lists after changes, and handle failed network requests.

We plan to develop and test one core flow at a time.

## Group details

- **Group number:** 36
- **Step 1 coordinator:** Mahmut Öztunçer

| Member | GitHub username | Step 1 responsibility |
| --- | --- | --- |
| Mahmut Öztunçer | [@mahmutoztuncer](https://github.com/mahmutoztuncer) | Coordinator; individual task assignment pending |
| Ceylin Zeynep Yüksel | Pending | Pending |
| Gence Genceli | Pending | Pending |
| Ilgın Emci | Pending | Pending |
| Kerem Mısırlıoğlu | Pending | Pending |

The coordinator organizes meetings, tracks task assignments, and communicates with the assigned TA. All members contribute to Step 1, review the final proposal, and explain their own work. Detailed task assignments and the remaining GitHub usernames still need to be confirmed.

## Repository guide

- [`PROJECT_PLAN.md`](PROJECT_PLAN.md): scope, Step 1 progress, and remaining submission tasks.
- [`CONTRIBUTING.md`](CONTRIBUTING.md): shared development workflow.
- [`.gitignore`](.gitignore): Flutter/Dart generated files, IDE settings, local configuration, and secrets.

The Flutter project structure and setup commands will be added when implementation begins.

**Repository:** https://github.com/mahmutoztuncer/cs310-mobile-project
