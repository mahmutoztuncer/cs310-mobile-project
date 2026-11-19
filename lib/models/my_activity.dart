import 'package:flutter/foundation.dart';

/// In-memory record of which announcements the demo user has joined.
/// Shared by Details (join/leave) and My Announcements (Joined tab).
/// Will be replaced by Firestore in Step 3.
class MyActivity {
  static final joinedIds = ValueNotifier<Set<String>>({});

  static bool hasJoined(String id) => joinedIds.value.contains(id);

  // A new Set is assigned each time so listeners are notified.
  static void join(String id) => joinedIds.value = {...joinedIds.value, id};

  static void leave(String id) =>
      joinedIds.value = {...joinedIds.value}..remove(id);

  /// Forget all joins (used on log out).
  static void clear() => joinedIds.value = {};
}