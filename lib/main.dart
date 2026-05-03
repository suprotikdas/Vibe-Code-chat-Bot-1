import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/env_manager.dart';
import 'core/theme/app_theme.dart';
import 'features/home/responsive_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment variables
  await EnvManager.init();

  runApp(
    const ProviderScope(
      child: VoterFlowApp(),
    ),
  );
}

class VoterFlowApp extends StatelessWidget {
  const VoterFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoterFlow Web',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ResponsiveScaffold(),
    );
  }
}
