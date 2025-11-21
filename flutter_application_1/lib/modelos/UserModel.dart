import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String photoUrl;
  final DateTime? createdAt;

  // Datos físicos
  final double height; // cm
  final double weight; // kg

  // Estadísticas globales
  final double totalDistance; // km
  final int totalRuns;
  final String averagePace;
  final int streakDays;

  // Objetivos
  final String currentGoal;

  // Eventos del usuario
  final List<String> myEventIds;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.photoUrl,
    required this.createdAt,
    required this.height,
    required this.weight,
    required this.totalDistance,
    required this.totalRuns,
    required this.averagePace,
    required this.streakDays,
    required this.currentGoal,
    required this.myEventIds,
  });

  /// ============================================================
  /// Convertir Firebase DocumentSnapshot → UserModel
  /// ============================================================
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),

      height: (data['height'] ?? 0).toDouble(),
      weight: (data['weight'] ?? 0).toDouble(),

      totalDistance: (data['totalDistance'] ?? 0).toDouble(),
      totalRuns: data['totalRuns'] ?? 0,
      averagePace: data['averagePace'] ?? "0:00",
      streakDays: data['streakDays'] ?? 0,

      currentGoal: data['currentGoal'] ?? '',
      myEventIds: List<String>.from(data['myEventIds'] ?? []),
    );
  }

  /// ============================================================
  /// Convertir UserModel → JSON para Firestore
  /// ============================================================
  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
    "createdAt": createdAt != null
        ? Timestamp.fromDate(createdAt!)
        : FieldValue.serverTimestamp(),
    "height": height,
    "weight": weight,
    "totalDistance": totalDistance,
    "totalRuns": totalRuns,
    "averagePace": averagePace,
    "streakDays": streakDays,
    "currentGoal": currentGoal,
    "myEventIds": myEventIds,
  };
}
