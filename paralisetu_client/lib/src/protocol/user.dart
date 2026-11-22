import 'package:serverpod_client/serverpod_client.dart';

class ParaliUser extends SerializableModel {
  int? id;
  String email;
  String name;
  String role;
  String? passwordHash;
  DateTime? createdAt;

  ParaliUser({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    this.passwordHash,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      if (passwordHash != null) 'passwordHash': passwordHash,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory ParaliUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliUser(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : DateTime.parse(jsonSerialization['createdAt'] as String),
    );
  }

  ParaliUser copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? passwordHash,
    DateTime? createdAt,
  }) {
    return ParaliUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
