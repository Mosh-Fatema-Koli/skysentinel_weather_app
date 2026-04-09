import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  List<String> _alerts = [];

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    final alerts = prefs.getStringList('alerts') ?? [];
    setState(() {
      _alerts = alerts.reversed.toList(); // latest first
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Alerts")),
      body: _alerts.isEmpty
          ? const Center(child: Text("No alerts yet"))
          : ListView.builder(
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.notification_important, color: Colors.red),
              title: Text(_alerts[index]),
            ),
          );
        },
      ),
    );
  }
}