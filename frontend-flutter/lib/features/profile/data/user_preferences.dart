class UserPreferences {
  final bool notificationsEnabled;
  final bool emailNotifications;
  final String language;
  final bool darkMode;

  const UserPreferences({
    this.notificationsEnabled = true,
    this.emailNotifications = true,
    this.language = 'fr',
    this.darkMode = false,
  });

  UserPreferences copyWith({bool? notificationsEnabled, bool? emailNotifications,
      String? language, bool? darkMode}) => UserPreferences(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        emailNotifications: emailNotifications ?? this.emailNotifications,
        language: language ?? this.language,
        darkMode: darkMode ?? this.darkMode,
      );

  factory UserPreferences.fromJson(Map<String, dynamic> j) => UserPreferences(
        notificationsEnabled: j['notificationsEnabled'] as bool? ?? true,
        emailNotifications: j['emailNotifications'] as bool? ?? true,
        language: j['language'] as String? ?? 'fr',
        darkMode: j['darkMode'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'notificationsEnabled': notificationsEnabled,
        'emailNotifications': emailNotifications,
        'language': language,
        'darkMode': darkMode,
      };
}