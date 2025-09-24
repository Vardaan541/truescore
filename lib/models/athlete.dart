import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

enum SportType {
  basketball,
  football,
  tennis,
  swimming,
  athletics,
  cycling,
  wheelchairBasketball,
  wheelchairTennis,
  paraSwimming,
  paraAthletics,
  other
}

enum ParticipationLevel { beginner, intermediate, advanced, professional }

class Athlete {
  final String id;
  final String userId;
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final String gender;
  final DisabilityType disabilityType;
  final String? disabilityDescription;
  final int? yearOfOnset;
  final bool hasParaSportClassification;
  final String? paraSportOrganization;
  final String? classificationCertificate;
  final List<SportType> sports;
  final ParticipationLevel participationLevel;
  final List<CompetitionHistory> competitionHistory;
  final PerformanceMetrics performanceMetrics;
  final List<Achievement> achievements;
  final int totalPoints;
  final int currentStreak;
  final DateTime lastTestDate;
  final String? profileImageUrl;
  final String? bio;
  final List<String> interests;
  final Map<String, dynamic>? socialLinks;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  Athlete({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.disabilityType,
    this.disabilityDescription,
    this.yearOfOnset,
    this.hasParaSportClassification = false,
    this.paraSportOrganization,
    this.classificationCertificate,
    required this.sports,
    required this.participationLevel,
    this.competitionHistory = const [],
    required this.performanceMetrics,
    this.achievements = const [],
    this.totalPoints = 0,
    this.currentStreak = 0,
    required this.lastTestDate,
    this.profileImageUrl,
    this.bio,
    this.interests = const [],
    this.socialLinks,
    this.isPublic = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Athlete.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Athlete(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      gender: data['gender'] ?? '',
      disabilityType: DisabilityType.values.firstWhere(
        (e) => e.toString() == 'DisabilityType.${data['disabilityType']}',
        orElse: () => DisabilityType.none,
      ),
      disabilityDescription: data['disabilityDescription'],
      yearOfOnset: data['yearOfOnset'],
      hasParaSportClassification: data['hasParaSportClassification'] ?? false,
      paraSportOrganization: data['paraSportOrganization'],
      classificationCertificate: data['classificationCertificate'],
      sports: (data['sports'] as List<dynamic>?)
              ?.map((s) => SportType.values.firstWhere(
                    (e) => e.toString() == 'SportType.$s',
                    orElse: () => SportType.other,
                  ))
              .toList() ??
          [],
      participationLevel: ParticipationLevel.values.firstWhere(
        (e) => e.toString() == 'ParticipationLevel.${data['participationLevel']}',
        orElse: () => ParticipationLevel.beginner,
      ),
      competitionHistory: (data['competitionHistory'] as List<dynamic>?)
              ?.map((c) => CompetitionHistory.fromMap(c))
              .toList() ??
          [],
      performanceMetrics: PerformanceMetrics.fromMap(data['performanceMetrics'] ?? {}),
      achievements: (data['achievements'] as List<dynamic>?)
              ?.map((a) => Achievement.fromMap(a))
              .toList() ??
          [],
      totalPoints: data['totalPoints'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
      lastTestDate: (data['lastTestDate'] as Timestamp).toDate(),
      profileImageUrl: data['profileImageUrl'],
      bio: data['bio'],
      interests: (data['interests'] as List<dynamic>?)?.cast<String>() ?? [],
      socialLinks: data['socialLinks'],
      isPublic: data['isPublic'] ?? true,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'gender': gender,
      'disabilityType': disabilityType.toString().split('.').last,
      'disabilityDescription': disabilityDescription,
      'yearOfOnset': yearOfOnset,
      'hasParaSportClassification': hasParaSportClassification,
      'paraSportOrganization': paraSportOrganization,
      'classificationCertificate': classificationCertificate,
      'sports': sports.map((s) => s.toString().split('.').last).toList(),
      'participationLevel': participationLevel.toString().split('.').last,
      'competitionHistory': competitionHistory.map((c) => c.toMap()).toList(),
      'performanceMetrics': performanceMetrics.toMap(),
      'achievements': achievements.map((a) => a.toMap()).toList(),
      'totalPoints': totalPoints,
      'currentStreak': currentStreak,
      'lastTestDate': Timestamp.fromDate(lastTestDate),
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'interests': interests,
      'socialLinks': socialLinks,
      'isPublic': isPublic,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

class CompetitionHistory {
  final String id;
  final String eventName;
  final String location;
  final DateTime date;
  final String position;
  final String category;
  final Map<String, dynamic>? results;

  CompetitionHistory({
    required this.id,
    required this.eventName,
    required this.location,
    required this.date,
    required this.position,
    required this.category,
    this.results,
  });

  factory CompetitionHistory.fromMap(Map<String, dynamic> map) {
    return CompetitionHistory(
      id: map['id'] ?? '',
      eventName: map['eventName'] ?? '',
      location: map['location'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      position: map['position'] ?? '',
      category: map['category'] ?? '',
      results: map['results'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'location': location,
      'date': Timestamp.fromDate(date),
      'position': position,
      'category': category,
      'results': results,
    };
  }
}

class PerformanceMetrics {
  final double strength;
  final double agility;
  final double stamina;
  final double speed;
  final double flexibility;
  final double coordination;
  final Map<String, double> sportSpecificMetrics;

  PerformanceMetrics({
    this.strength = 0.0,
    this.agility = 0.0,
    this.stamina = 0.0,
    this.speed = 0.0,
    this.flexibility = 0.0,
    this.coordination = 0.0,
    this.sportSpecificMetrics = const {},
  });

  factory PerformanceMetrics.fromMap(Map<String, dynamic> map) {
    return PerformanceMetrics(
      strength: (map['strength'] ?? 0.0).toDouble(),
      agility: (map['agility'] ?? 0.0).toDouble(),
      stamina: (map['stamina'] ?? 0.0).toDouble(),
      speed: (map['speed'] ?? 0.0).toDouble(),
      flexibility: (map['flexibility'] ?? 0.0).toDouble(),
      coordination: (map['coordination'] ?? 0.0).toDouble(),
      sportSpecificMetrics: Map<String, double>.from(map['sportSpecificMetrics'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'strength': strength,
      'agility': agility,
      'stamina': stamina,
      'speed': speed,
      'flexibility': flexibility,
      'coordination': coordination,
      'sportSpecificMetrics': sportSpecificMetrics,
    };
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final DateTime earnedDate;
  final int points;
  final AchievementType type;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.earnedDate,
    required this.points,
    required this.type,
  });

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      iconUrl: map['iconUrl'] ?? '',
      earnedDate: (map['earnedDate'] as Timestamp).toDate(),
      points: map['points'] ?? 0,
      type: AchievementType.values.firstWhere(
        (e) => e.toString() == 'AchievementType.${map['type']}',
        orElse: () => AchievementType.badge,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconUrl': iconUrl,
      'earnedDate': Timestamp.fromDate(earnedDate),
      'points': points,
      'type': type.toString().split('.').last,
    };
  }
}

enum AchievementType { badge, streak, milestone, competition }
