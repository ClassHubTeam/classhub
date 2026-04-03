import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config.dart';
import 'onboarding/ui/screens/onboarding_screen.dart';
import 'file_explorer/ui/screens/file_explorer_screen.dart';
import 'core/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  final String? rootPath = prefs.getString('root_path');
  // final String? rootPath = 'my-user-picked-file';
  // final String? rootPath = null;

  if (rootPath != null) {
    ClasshubConfig.rootPath = rootPath;
  }

  runApp(
    ClasshubApp(
      isSetupComplete: rootPath != null,
      rootPath: ClasshubConfig.rootPath,
    ),
  );
}

class ClasshubApp extends StatelessWidget {
  final bool isSetupComplete;
  final String? rootPath;

  const ClasshubApp({
    super.key,
    required this.isSetupComplete,
    required this.rootPath,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isSetupComplete ? FileExplorerScreen() : OnboardingScreen(),
    );
  }
}
