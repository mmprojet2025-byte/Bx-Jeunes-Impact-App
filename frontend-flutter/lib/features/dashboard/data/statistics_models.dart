class AppStats {
  final int totalMembers;
  final int totalActivities;
  final int totalProjects;
  final int activeGroups;
  final Map<String, int> membersByRole;
  final Map<String, int> projectsByStatus;
  final List<MonthlyActivity> monthlyActivities;

  const AppStats({
    required this.totalMembers,
    required this.totalActivities,
    required this.totalProjects,
    required this.activeGroups,
    required this.membersByRole,
    required this.projectsByStatus,
    required this.monthlyActivities,
  });

  factory AppStats.fromJson(Map<String, dynamic> j) => AppStats(
        totalMembers: j['totalMembers'] as int? ?? 0,
        totalActivities: j['totalActivities'] as int? ?? 0,
        totalProjects: j['totalProjects'] as int? ?? 0,
        activeGroups: j['activeGroups'] as int? ?? 0,
        membersByRole: (j['membersByRole'] as Map<String, dynamic>? ?? {})
            .map((k, v) => MapEntry(k, v as int)),
        projectsByStatus: (j['projectsByStatus'] as Map<String, dynamic>? ?? {})
            .map((k, v) => MapEntry(k, v as int)),
        monthlyActivities: (j['monthlyActivities'] as List? ?? [])
            .map((e) => MonthlyActivity.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class MonthlyActivity {
  final String month;
  final int count;
  const MonthlyActivity({required this.month, required this.count});
  factory MonthlyActivity.fromJson(Map<String, dynamic> j) =>
      MonthlyActivity(month: j['month'] as String, count: j['count'] as int);
}