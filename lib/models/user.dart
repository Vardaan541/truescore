import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { athlete, paraAthlete, official }

enum DisabilityType { none, limb, visual, hearing, other }

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final Map<String, dynamic>? preferences;
  final AccessibilitySettings? accessibilitySettings;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.preferences,
    this.accessibilitySettings,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${data['role']}',
        orElse: () => UserRole.athlete,
      ),
      profileImageUrl: data['profileImageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
      preferences: data['preferences'],
      accessibilitySettings: data['accessibilitySettings'] != null
          ? AccessibilitySettings.fromMap(data['accessibilitySettings'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
      'preferences': preferences,
      'accessibilitySettings': accessibilitySettings?.toMap(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    Map<String, dynamic>? preferences,
    AccessibilitySettings? accessibilitySettings,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      preferences: preferences ?? this.preferences,
      accessibilitySettings: accessibilitySettings ?? this.accessibilitySettings,
    );
  }
}

class AccessibilitySettings {
  final bool textToSpeech;
  final bool largeFonts;
  final bool highContrast;
  final bool colorBlindFriendly;
  final String language;
  final double fontSize;

  AccessibilitySettings({
    this.textToSpeech = false,
    this.largeFonts = false,
    this.highContrast = false,
    this.colorBlindFriendly = false,
    this.language = 'en',
    this.fontSize = 16.0,
  });

  factory AccessibilitySettings.fromMap(Map<String, dynamic> map) {
    return AccessibilitySettings(
      textToSpeech: map['textToSpeech'] ?? false,
      largeFonts: map['largeFonts'] ?? false,
      highContrast: map['highContrast'] ?? false,
      colorBlindFriendly: map['colorBlindFriendly'] ?? false,
      language: map['language'] ?? 'en',
      fontSize: (map['fontSize'] ?? 16.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'textToSpeech': textToSpeech,
      'largeFonts': largeFonts,
      'highContrast': highContrast,
      'colorBlindFriendly': colorBlindFriendly,
      'language': language,
      'fontSize': fontSize,
    };
  }
}
