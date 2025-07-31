import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/providers/debug_provider_observer.dart';

class DebugMenuScreen extends StatelessWidget {
  const DebugMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerList = providerValues.entries.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('🧪 Debug Menu')),
      body: ListView.builder(
        itemCount: providerList.length,
        itemBuilder: (context, index) {
          final entry = providerList[index];
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value.toString()),
          );
        },
      ),
    );
  }
}
