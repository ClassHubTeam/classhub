import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/config.dart';
import '../../../file_explorer/ui/screens/file_explorer_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> pickAndSaveFolder(BuildContext context) async {
    final String? selectedPath = await FilePicker.platform.getDirectoryPath();
    if (selectedPath != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('root_path', selectedPath);
      ClasshubConfig.rootPath = selectedPath;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FileExplorerScreen()),
      );
    }
  }

  void goToExplorer(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const FileExplorerScreen()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected: ${ClasshubConfig.rootPath}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => pickAndSaveFolder(context),
              child: const Text('Pick other Folder'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => goToExplorer(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
