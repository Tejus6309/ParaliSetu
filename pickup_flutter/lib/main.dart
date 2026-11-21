import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(title: 'ParaliSetu Pickup',
    theme: ThemeData(colorSchemeSeed: const Color(0xff653848)),
    home: const PickupPage()));

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});
  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  final client = http.Client();
  String role = '', error = '';
  List<dynamic> orders = [];
  int? selected;
  Map<String, dynamic>? room;
  Timer? timer;
  bool busy = false;

  Future<dynamic> request(String path, {bool post = false}) async {
    final uri = Uri.base.resolve('/api$path');
    final response = post
        ? await client.post(uri, headers: {'X-Parali-Client': '1'})
        : await client.get(uri);
    if (response.statusCode == 401) {
      throw Exception('Sign in to ParaliSetu in this browser, then tap Refresh.');
    }
    if (response.statusCode >= 400) {
      throw Exception('Request failed (${response.statusCode}).');
    }
    return jsonDecode(response.body);
  }

  @override
  void initState() { super.initState(); loadOrders(); }

  Future<void> loadOrders() async {
    try {
      final user = await request('/auth/me');
      if (!['FARMER', 'LOGISTICS'].contains(user['role'])) {
        throw Exception('Use a farmer or logistics account to check in.');
      }
      final rows = await request('/orders') as List;
      if (!mounted) return;
      setState(() {
        role = user['role']; error = '';
        orders = rows.where((o) => o['status'] == 'ASSIGNED').toList();
      });
    } catch (e) { if (mounted) setState(() => error = e.toString()); }
  }

  Future<void> refreshRoom(int id) async {
    try {
      final result = await request('/orders/$id/pickup-room');
      if (mounted && selected == id) setState(() { room = result; error = ''; });
    } catch (e) {
      if (mounted && selected == id) setState(() => error = e.toString());
    } finally {
      if (mounted && selected == id) {
        timer = Timer(const Duration(seconds: 2), () => refreshRoom(id));
      }
    }
  }

  Future<void> arrive() async {
    final id = selected;
    if (id == null || busy) return;
    setState(() => busy = true);
    try {
      final result = await request('/orders/$id/pickup-room/arrive', post: true);
      if (mounted && selected == id) setState(() { room = result; error = ''; });
    } catch (e) { if (mounted) setState(() => error = e.toString()); }
    finally { if (mounted) setState(() => busy = false); }
  }

  @override
  void dispose() { timer?.cancel(); client.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final data = room;
    return Scaffold(appBar: AppBar(title: const Text('ParaliSetu pickup')),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
        if (error.isNotEmpty) Text(error),
        if (selected == null) ...[
          Text('Assigned pickups', style: Theme.of(context).textTheme.headlineSmall),
          if (orders.isEmpty && error.isEmpty) const Text('No assigned pickups.'),
          for (final o in orders) ListTile(title: Text('Order #${o["id"]} · ${o["crop"]}'),
            subtitle: Text('${o["district"]} · ${o["quantity_kg"]} kg'),
            onTap: () { setState(() { selected = o['id']; room = null; }); refreshRoom(o['id']); }),
          OutlinedButton(onPressed: loadOrders, child: const Text('Refresh')),
        ] else ...[
          Text('Pickup room #$selected', style: Theme.of(context).textTheme.headlineSmall),
          if (data != null) ...[
            for (final member in ['farmer','carrier']) ListTile(
              title: Text(data['${member}_name']),
              subtitle: Text(data['${member}_arrived_at'] == null ? 'Awaiting check-in' : 'At pickup')),
            if (data['status'] != 'ASSIGNED') Text('Room closed · ${data["status"]}')
            else if (data[role == 'FARMER' ? 'farmer_arrived_at' : 'carrier_arrived_at'] == null)
              FilledButton(onPressed: busy ? null : arrive, child: const Text('I am at the pickup site')),
          ],
          TextButton(onPressed: () { timer?.cancel(); setState(() { selected = null; room = null; }); loadOrders(); },
            child: const Text('Back to assigned pickups')),
        ]
      ])));
  }
}
