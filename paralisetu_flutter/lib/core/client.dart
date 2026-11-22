import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_client/paralisetu_client.dart';

/// Single shared Serverpod client instance provider across the entire Flutter application.
/// Avoids creating multiple independent client connections.
final clientProvider = Provider<Client>((ref) {
  // Configured to point to the Serverpod backend at port 8080 by default
  const serverHost = String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:8080/');
  final client = Client(serverHost);
  return client;
});
