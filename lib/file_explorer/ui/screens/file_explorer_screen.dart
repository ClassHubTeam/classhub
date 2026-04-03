import 'dart:io';
import 'package:classhub/onboarding/ui/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/config.dart';

class FileExplorerScreen extends StatelessWidget {
  const FileExplorerScreen({super.key});

  void goToOnboarding(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const OnboardingScreen()),
  );

  @override
  Widget build(BuildContext context) {
    final dir = Directory(ClasshubConfig.rootPath);

    if (ClasshubConfig.rootPath.isEmpty || !dir.existsSync()) {
      return Scaffold(
        appBar: AppBar(title: const Text('File Explorer')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.folder_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('No folder selected or folder no longer exists.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => goToOnboarding(context),
                child: const Text('Pick a Folder'),
              ),
            ],
          ),
        ),
      );
    }

    final contents = dir.listSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => goToOnboarding(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final entity = contents[index];
          final name = entity.path.split('/').last;
          final isDir = entity is Directory;
          return ListTile(
            leading: Icon(isDir ? Icons.folder : Icons.insert_drive_file),
            title: Text(name),
          );
        },
      ),
    );
  }
}
