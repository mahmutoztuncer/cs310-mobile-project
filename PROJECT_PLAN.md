# CoSUtudy project plan

## Project baseline

- **Course:** CS310 Mobile Application Development
- **Group:** 36
- **Step 1 coordinator:** Mahmut Öztunçer
- **Current stage:** Proposal and repository setup; no application implementation yet.
- **Members:** Mahmut Öztunçer, Ceylin Zeynep Yüksel, Gence Genceli, Ilgın Emci, Kerem Mısırlıoğlu.

## Agreed first version

A Flutter application for finding study partners and course project teammates on one campus. Study sessions and project team announcements share a direct join and leave process.

### Core flows

- Register with a name, student ID, university email address, and password; sign in.
- Create a study session or project team announcement with a course code, title, description, and capacity.
- Add a meeting location, date, and time for study sessions.
- Browse announcements and filter by course code and type.
- View participant names and remaining places; join or leave an announcement.
- View created and joined announcements; close or delete an owned announcement.

### Optional and excluded features

Announcement editing is optional. Chat, notifications, calendar integration, automatic matching, and application approval workflows are outside the planned scope.

### Planned data and safeguards

Use Firebase Authentication for login and Cloud Firestore for users, announcements, and participation. User data includes student IDs, consistent with the registration requirements. Announcements need an open or closed status. Passwords are handled by the authentication service.

During implementation, verify that capacity cannot be exceeded, users cannot join the same announcement twice, closed announcements reject new joins, and users cannot manage another user's announcements or participation.

## Step 1 checklist

### Repository

- [x] Create the public repository and verify its link.
- [x] Include a Flutter .gitignore and initial commit.
- [x] Document the agreed app concept, scope, group number, coordinator, and member names.
- [ ] Confirm all group members' GitHub usernames.
- [ ] Invite all group members as collaborators and verify acceptance.
- [ ] Confirm individual Step 1 task assignments and record them in the proposal and README.
- [ ] Verify instructor and assigned TA access.

### Proposal and review

- [x] Prepare a draft covering the app overview, core and optional features, data requirements, and potential challenges.
- [x] Add the project title, group number, coordinator, member names, and repository link to the draft.
- [ ] Complete all student IDs in the course submission document.
- [ ] Complete the Step 1 task allocation table for every member.
- [ ] Review the registration and data sections together so both include student ID and university email requirements.
- [ ] Clarify any ambiguous wording about announcement creation before final submission.
- [ ] Share the draft proposal and repository link with the assigned TA and incorporate feedback.
- [ ] Have all members review the final proposal.
- [ ] Export the completed proposal as a 1-2 page PDF and submit one copy per group through SUCourse.

### Dates stated in the course handout

- Initial draft: 22 October, 23:59.
- Final submission: 25 October, 23:59.

The handout does not specify a year or timezone. Confirm the deadline details in SUCourse.

## Team coordination

The Step 1 coordinator organizes meetings, coordinates task assignments, and communicates with the assigned TA. Individual assignments remain to be agreed by the team. Each later project step will have a different coordinator, in line with the course handout.

Use GitHub Issues to track agreed tasks and pull requests to review changes. Add later project requirements and dates when the corresponding course instructions are released.
