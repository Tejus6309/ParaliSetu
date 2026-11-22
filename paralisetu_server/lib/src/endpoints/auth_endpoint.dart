import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  String _hashPassword(String password) {
    return sha256.convert(utf8.encode('paralisetu_salt_$password')).toString();
  }

  Future<ParaliUser?> login(Session session, String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();
    final users = await session.db.find<ParaliUser>(
      where: (t) => t.email.equals(normalizedEmail),
      limit: 1,
    );

    if (users.isEmpty) {
      throw EndpointException(
        message: 'Invalid email or password.',
        errorType: EndpointExceptionType.unauthorized,
      );
    }

    final user = users.first;
    final hash = _hashPassword(password);
    if (user.passwordHash != hash) {
      throw EndpointException(
        message: 'Invalid email or password.',
        errorType: EndpointExceptionType.unauthorized,
      );
    }

    // Return user with password omitted
    return user.copyWith(passwordHash: '');
  }

  Future<ParaliUser> register(
    Session session,
    String name,
    String email,
    String password,
    String role,
  ) async {
    final cleanRole = role.trim().toUpperCase();
    if (!['FARMER', 'BUYER'].contains(cleanRole)) {
      throw EndpointException(
        message: 'Self-registration is available for farmers and buyers.',
        errorType: EndpointExceptionType.badRequest,
      );
    }

    final passwordBytes = utf8.encode(password);
    if (passwordBytes.length < 10 || passwordBytes.length > 72) {
      throw EndpointException(
        message: 'Password must be between 10 and 72 characters.',
        errorType: EndpointExceptionType.badRequest,
      );
    }

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.endsWith('@demo.paralisetu.org')) {
      throw EndpointException(
        message: 'Use a regular email address for registration.',
        errorType: EndpointExceptionType.badRequest,
      );
    }

    final existing = await session.db.find<ParaliUser>(
      where: (t) => t.email.equals(normalizedEmail),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      throw EndpointException(
        message: 'An account already exists for that email.',
        errorType: EndpointExceptionType.conflict,
      );
    }

    final user = ParaliUser(
      email: normalizedEmail,
      name: name.trim(),
      role: cleanRole,
      passwordHash: _hashPassword(password),
      createdAt: DateTime.now(),
    );

    final inserted = await session.db.insertRow<ParaliUser>(user);
    return inserted.copyWith(passwordHash: '');
  }

  Future<ParaliUser?> me(Session session, int userId) async {
    final user = await session.db.findById<ParaliUser>(userId);
    return user?.copyWith(passwordHash: '');
  }
}

enum EndpointExceptionType { badRequest, unauthorized, forbidden, notFound, conflict }

class EndpointException implements Exception {
  final String message;
  final EndpointExceptionType errorType;
  EndpointException({required this.message, required this.errorType});

  @override
  String toString() => message;
}
