/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ParaliUser
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ParaliUser._({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.passwordHash,
    this.createdAt,
  });

  factory ParaliUser({
    int? id,
    required String email,
    required String name,
    required String role,
    required String passwordHash,
    DateTime? createdAt,
  }) = _ParaliUserImpl;

  factory ParaliUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParaliUser(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String email;

  String name;

  String role;

  String passwordHash;

  DateTime? createdAt;

  /// Returns a shallow copy of this [ParaliUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ParaliUser copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? passwordHash,
    DateTime? createdAt = const _isc.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParaliUser',
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      'passwordHash': passwordHash,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParaliUser',
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      'passwordHash': passwordHash,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParaliUserImpl extends ParaliUser {
  _ParaliUserImpl({
    int? id,
    required String email,
    required String name,
    required String role,
    required String passwordHash,
    DateTime? createdAt,
  }) : super._(
          id: id,
          email: email,
          name: name,
          role: role,
          passwordHash: passwordHash,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ParaliUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ParaliUser copyWith({
    Object? id = _Undefined,
    String? email,
    String? name,
    String? role,
    String? passwordHash,
    DateTime? createdAt = const _isc.$UndefinedDateTime(),
  }) {
    return ParaliUser(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt:
          createdAt is _isc.UndefinedSentinel ? this.createdAt : createdAt,
    );
  }
}
