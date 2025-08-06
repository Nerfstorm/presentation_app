import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/tech_marquee.dart';
import 'widgets/profile_section.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(const PortfolioApp());

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      scrollBehavior: AppScrollBehavior(),
      themeMode: ThemeMode.dark, // Use dark mode always
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2149CE),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2149CE),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  final List<String> techStack = const [
    'Dart',
    'Flutter',
    'Python',
    'PyTorch',
    'Git',
    'SQL',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ① Wrap the whole body in a Container with a gradient:
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D1B2A), // dark navy
              Color(0xFF1B263B), // slightly lighter
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ② Make the title logo bigger:
                  SvgPicture.asset(
                    'assets/svg/title.svg',
                    width: 300, // ↑ from 200 → 300
                    semanticsLabel: 'Title Logo',
                  ),
                  const SizedBox(height: 40),

                  // ③ Scale up each ProfileSection slightly:
                  Transform.scale(
                    scale: 1.05, // 5% larger
                    child: ProfileSection(
                      jsonAsset: 'assets/thomas.json',
                      name: 'Thomas',
                      occupation: 'Flutter Developer',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Transform.scale(
                    scale: 1.05,
                    child: ProfileSection(
                      jsonAsset: 'assets/teodor.json',
                      name: 'Teodor',
                      occupation: 'Hydrologist & ML Engineer',
                    ),
                  ),

                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tech & Frameworks',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontSize: 28), // bump font size
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TechMarquee(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
