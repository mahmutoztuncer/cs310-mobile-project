
enum AnnouncementType { studySession, projectTeam }

class Announcement {
  final String id;
  final AnnouncementType type;
  final String courseCode;
  final String title;
  final String description;
  final int capacity;
  final int joinedCount;
  final String? location; // study sessions only
  final DateTime? dateTime; // study sessions only
  final String creatorName;
  final String creatorPhotoUrl;

  const Announcement({
    required this.id,
    required this.type,
    required this.courseCode,
    required this.title,
    required this.description,
    required this.capacity,
    required this.joinedCount,
    this.location,
    this.dateTime,
    required this.creatorName,
    required this.creatorPhotoUrl,
  });
}

final List<Announcement> sampleAnnouncements = [
  Announcement(
    id: '1',
    type: AnnouncementType.studySession,
    courseCode: 'CS310',
    title: 'Flutter widgets review',
    description: 'Going over layout widgets before the midterm.',
    capacity: 4,
    joinedCount: 2,
    location: 'IC Library',
    dateTime: DateTime(2026, 11, 20, 14, 0),
    creatorName: 'Ceylin Yüksel',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=47',
  ),
  const Announcement(
    id: '2',
    type: AnnouncementType.projectTeam,
    courseCode: 'CS308',
    title: 'Looking for 2 teammates',
    description: 'Online store project, React + Node.',
    capacity: 6,
    joinedCount: 4,
    creatorName: 'Kerem Mısırlıoğlu',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=12',
  ),
  Announcement(
    id: '3',
    type: AnnouncementType.studySession,
    courseCode: 'MATH201',
    title: 'Linear algebra problem session',
    description: 'Solving past exam questions together.',
    capacity: 5,
    joinedCount: 1,
    location: 'FENS G032',
    dateTime: DateTime(2026, 11, 21, 18, 30),
    creatorName: 'Ilgın Emci',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=32',
  ),
  // Created by the demo user (Ayşe Yılmaz), shown in My Announcements.
  Announcement(
    id: 'my-1',
    type: AnnouncementType.studySession,
    courseCode: 'CS301',
    title: 'Dynamic programming practice',
    description: 'Working through DP problems from the problem sets.',
    capacity: 3,
    joinedCount: 1,
    location: 'IC Library',
    dateTime: DateTime(2026, 11, 23, 16, 0),
    creatorName: 'Ayşe Yılmaz',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=5',
  ),
  const Announcement(
    id: 'my-2',
    type: AnnouncementType.projectTeam,
    courseCode: 'CS310',
    title: 'Need 1 more teammate',
    description: 'Flutter app project, the UI is mostly done.',
    capacity: 5,
    joinedCount: 4,
    creatorName: 'Ayşe Yılmaz',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=5',
  ),
  Announcement(
    id: 'my-3',
    type: AnnouncementType.studySession,
    courseCode: 'MATH204',
    title: 'Quiz prep',
    description: 'Reviewing the weekly topics before the quiz.',
    capacity: 6,
    joinedCount: 2,
    location: 'FENS L045',
    dateTime: DateTime(2026, 11, 24, 19, 0),
    creatorName: 'Ayşe Yılmaz',
    creatorPhotoUrl: 'https://i.pravatar.cc/100?img=5',
  ),
];
