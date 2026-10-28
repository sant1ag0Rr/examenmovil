import 'package:flutter/material.dart';

import 'pages/sample_list_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SampleTrackApp());
}

class SampleTrackApp extends StatelessWidget {
  const SampleTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SampleTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SampleListPage(),
    );
  }
}
