import 'package:serverpod/serverpod.dart';
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'src/demo_data.dart';

void run(List<String> args) async {
  // Initialize Serverpod and connect it with the generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Setup demo data seeding hook on startup
  pod.webServer.addRoute(RouteRoot(), '/');

  // Start the server.
  await pod.start();

  // Run demo seeder within a serverpod session
  try {
    final session = await pod.createSession();
    await DemoData.seedIfEmpty(session);
    await session.close();
  } catch (e) {
    // If database connection is not yet configured, server continues cleanly
    print('Notice: Database not connected or seeder skipped: $e');
  }
}

class RouteRoot extends WidgetRoute {
  @override
  Future<WebWidget?> build(Session session, Request request) async {
    return SimpleWidget(
      text: 'ParaliSetu Serverpod Backend is running! Connect using paralisetu_client.',
    );
  }
}

class SimpleWidget extends WebWidget {
  final String text;
  SimpleWidget({required this.text});

  @override
  String render({String? Function(String)? onMissingVariable}) =>
      '<html><body><h1>$text</h1></body></html>';
}
