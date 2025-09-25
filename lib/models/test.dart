import 'package:cloud_firestore/cloud_firestore.dart';
import 'athlete.dart';

enum TestType { generalFitness, sportSpecific, paraAthleteAdaptive, custom }

enum TestStatus { pending, inProgress, completed, cancelled }

class Test {
  final String id;
  final String name;
  final String description;
  final TestType type;
  final SportType? sportType;
  final List<TestExercise> exercises;
  final int estimatedDuration; // in minutes
  final String instructions;
  final String? videoUrl;
  final List<String> prerequisites;
  final bool requiresCamera;
  final bool isAIGuided;
  final Map<String, dynamic>? aiSettings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Test({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.sportType,
    required this.exercises,
    required this.estimatedDuration,
    required this.instructions,
    this.videoUrl,
    this.prerequisites = const [],
    this.requiresCamera = false,
    this.isAIGuided = false,
    this.aiSettings,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory Test.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Test(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      type: TestType.values.firstWhere(
        (e) => e.toString() == 'TestType.${data['type']}',
        orElse: () => TestType.generalFitness,
      ),
      sportType: data['sportType'] != null
          ? SportType.values.firstWhere(
              (e) => e.toString() == 'SportType.${data['sportType']}',
              orElse: () => SportType.other,
            )
          : null,
      exercises:
          (data['exercises'] as List<dynamic>?)
              ?.map((e) => TestExercise.fromMap(e))
              .toList() ??
          [],
      estimatedDuration: data['estimatedDuration'] ?? 0,
      instructions: data['instructions'] ?? '',
      videoUrl: data['videoUrl'],
      prerequisites:
          (data['prerequisites'] as List<dynamic>?)?.cast<String>() ?? [],
      requiresCamera: data['requiresCamera'] ?? false,
      isAIGuided: data['isAIGuided'] ?? false,
      aiSettings: data['aiSettings'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'sportType': sportType?.toString().split('.').last,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'estimatedDuration': estimatedDuration,
      'instructions': instructions,
      'videoUrl': videoUrl,
      'prerequisites': prerequisites,
      'requiresCamera': requiresCamera,
      'isAIGuided': isAIGuided,
      'aiSettings': aiSettings,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }
}

class TestExercise {
  final String id;
  final String name;
  final String description;
  final ExerciseType type;
  final int duration; // in seconds
  final int? repetitions;
  final String instructions;
  final String? videoUrl;
  final Map<String, dynamic>? aiTrackingSettings;
  final List<String> targetMuscles;
  final DifficultyLevel difficulty;

  TestExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.duration,
    this.repetitions,
    required this.instructions,
    this.videoUrl,
    this.aiTrackingSettings,
    this.targetMuscles = const [],
    required this.difficulty,
  });

  factory TestExercise.fromMap(Map<String, dynamic> map) {
    return TestExercise(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      type: ExerciseType.values.firstWhere(
        (e) => e.toString() == 'ExerciseType.${map['type']}',
        orElse: () => ExerciseType.strength,
      ),
      duration: map['duration'] ?? 0,
      repetitions: map['repetitions'],
      instructions: map['instructions'] ?? '',
      videoUrl: map['videoUrl'],
      aiTrackingSettings: map['aiTrackingSettings'],
      targetMuscles:
          (map['targetMuscles'] as List<dynamic>?)?.cast<String>() ?? [],
      difficulty: DifficultyLevel.values.firstWhere(
        (e) => e.toString() == 'DifficultyLevel.${map['difficulty']}',
        orElse: () => DifficultyLevel.beginner,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'duration': duration,
      'repetitions': repetitions,
      'instructions': instructions,
      'videoUrl': videoUrl,
      'aiTrackingSettings': aiTrackingSettings,
      'targetMuscles': targetMuscles,
      'difficulty': difficulty.toString().split('.').last,
    };
  }
}

enum ExerciseType {
  strength,
  cardio,
  flexibility,
  balance,
  coordination,
  sportSpecific,
}

enum DifficultyLevel { beginner, intermediate, advanced, expert }

class TestSession {
  final String id;
  final String athleteId;
  final String testId;
  final TestStatus status;
  final DateTime startedAt;
  final DateTime? completedAt;
  final List<TestResult> results;
  final Map<String, dynamic>? aiAnalysis;
  final String? videoRecordingUrl;
  final Map<String, dynamic>? metadata;

  TestSession({
    required this.id,
    required this.athleteId,
    required this.testId,
    required this.status,
    required this.startedAt,
    this.completedAt,
    this.results = const [],
    this.aiAnalysis,
    this.videoRecordingUrl,
    this.metadata,
  });

  factory TestSession.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TestSession(
      id: doc.id,
      athleteId: data['athleteId'] ?? '',
      testId: data['testId'] ?? '',
      status: TestStatus.values.firstWhere(
        (e) => e.toString() == 'TestStatus.${data['status']}',
        orElse: () => TestStatus.pending,
      ),
      startedAt: (data['startedAt'] as Timestamp).toDate(),
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      results:
          (data['results'] as List<dynamic>?)
              ?.map((r) => TestResult.fromMap(r))
              .toList() ??
          [],
      aiAnalysis: data['aiAnalysis'],
      videoRecordingUrl: data['videoRecordingUrl'],
      metadata: data['metadata'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'athleteId': athleteId,
      'testId': testId,
      'status': status.toString().split('.').last,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'results': results.map((r) => r.toMap()).toList(),
      'aiAnalysis': aiAnalysis,
      'videoRecordingUrl': videoRecordingUrl,
      'metadata': metadata,
    };
  }
}

class TestResult {
  final String id;
  final String exerciseId;
  final int repetitions;
  final double duration; // in seconds
  final double accuracy;
  final double formScore;
  final Map<String, dynamic>? aiFeedback;
  final List<String> improvements;
  final DateTime recordedAt;

  TestResult({
    required this.id,
    required this.exerciseId,
    required this.repetitions,
    required this.duration,
    required this.accuracy,
    required this.formScore,
    this.aiFeedback,
    this.improvements = const [],
    required this.recordedAt,
  });

  factory TestResult.fromMap(Map<String, dynamic> map) {
    return TestResult(
      id: map['id'] ?? '',
      exerciseId: map['exerciseId'] ?? '',
      repetitions: map['repetitions'] ?? 0,
      duration: (map['duration'] ?? 0.0).toDouble(),
      accuracy: (map['accuracy'] ?? 0.0).toDouble(),
      formScore: (map['formScore'] ?? 0.0).toDouble(),
      aiFeedback: map['aiFeedback'],
      improvements:
          (map['improvements'] as List<dynamic>?)?.cast<String>() ?? [],
      recordedAt: (map['recordedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'repetitions': repetitions,
      'duration': duration,
      'accuracy': accuracy,
      'formScore': formScore,
      'aiFeedback': aiFeedback,
      'improvements': improvements,
      'recordedAt': Timestamp.fromDate(recordedAt),
    };
  }
}

