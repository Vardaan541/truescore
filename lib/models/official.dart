import 'package:cloud_firestore/cloud_firestore.dart';

enum OfficialType { coach, judge, recruiter, scout }

class Official {
  final String id;
  final String userId;
  final String name;
  final String email;
  final OfficialType type;
  final String organization;
  final String? profileImageUrl;
  final String? bio;
  final List<String> specializations;
  final List<String> certifications;
  final Map<String, dynamic>? contactInfo;
  final List<String> shortlistedAthletes;
  final List<Evaluation> evaluations;
  final Map<String, dynamic>? preferences;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Official({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.type,
    required this.organization,
    this.profileImageUrl,
    this.bio,
    this.specializations = const [],
    this.certifications = const [],
    this.contactInfo,
    this.shortlistedAthletes = const [],
    this.evaluations = const [],
    this.preferences,
    this.isVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Official.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Official(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      type: OfficialType.values.firstWhere(
        (e) => e.toString() == 'OfficialType.${data['type']}',
        orElse: () => OfficialType.coach,
      ),
      organization: data['organization'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      bio: data['bio'],
      specializations:
          (data['specializations'] as List<dynamic>?)?.cast<String>() ?? [],
      certifications:
          (data['certifications'] as List<dynamic>?)?.cast<String>() ?? [],
      contactInfo: data['contactInfo'],
      shortlistedAthletes:
          (data['shortlistedAthletes'] as List<dynamic>?)?.cast<String>() ?? [],
      evaluations:
          (data['evaluations'] as List<dynamic>?)
              ?.map((e) => Evaluation.fromMap(e))
              .toList() ??
          [],
      preferences: data['preferences'],
      isVerified: data['isVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'type': type.toString().split('.').last,
      'organization': organization,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'specializations': specializations,
      'certifications': certifications,
      'contactInfo': contactInfo,
      'shortlistedAthletes': shortlistedAthletes,
      'evaluations': evaluations.map((e) => e.toMap()).toList(),
      'preferences': preferences,
      'isVerified': isVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

class Evaluation {
  final String id;
  final String athleteId;
  final String officialId;
  final String testId;
  final Map<String, double> scores;
  final String? comments;
  final List<String> strengths;
  final List<String> improvements;
  final bool isShortlisted;
  final DateTime evaluatedAt;

  Evaluation({
    required this.id,
    required this.athleteId,
    required this.officialId,
    required this.testId,
    required this.scores,
    this.comments,
    this.strengths = const [],
    this.improvements = const [],
    this.isShortlisted = false,
    required this.evaluatedAt,
  });

  factory Evaluation.fromMap(Map<String, dynamic> map) {
    return Evaluation(
      id: map['id'] ?? '',
      athleteId: map['athleteId'] ?? '',
      officialId: map['officialId'] ?? '',
      testId: map['testId'] ?? '',
      scores: Map<String, double>.from(map['scores'] ?? {}),
      comments: map['comments'],
      strengths: (map['strengths'] as List<dynamic>?)?.cast<String>() ?? [],
      improvements:
          (map['improvements'] as List<dynamic>?)?.cast<String>() ?? [],
      isShortlisted: map['isShortlisted'] ?? false,
      evaluatedAt: (map['evaluatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'athleteId': athleteId,
      'officialId': officialId,
      'testId': testId,
      'scores': scores,
      'comments': comments,
      'strengths': strengths,
      'improvements': improvements,
      'isShortlisted': isShortlisted,
      'evaluatedAt': Timestamp.fromDate(evaluatedAt),
    };
  }
}
