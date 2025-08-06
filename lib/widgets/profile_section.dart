import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation_app/widgets/looping_carrousel.dart';
import '../models/project.dart';
import 'vs_card.dart';
import 'project_tile.dart';

class ProfileSection extends StatelessWidget {
  final String jsonAsset;
  final String name;
  final String occupation;

  const ProfileSection({
    super.key,
    required this.jsonAsset,
    required this.name,
    required this.occupation,
  });

  Future<List<Project>> _loadProjects() async {
    final raw = await rootBundle.loadString(jsonAsset);
    final List data = json.decode(raw) as List;
    return data
        .map((e) => Project.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _loadProjects(),
      builder: (ctx, snap) {
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snap.hasError) {
              return Center(child: Text('Error: ${snap.error}'));
            }
            final projects = snap.data!;
            final isRight = name == 'Thomas';

            return Align(
              alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 2 / 3,
                child: VsCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          occupation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        LoopingCarousel(
                          count: projects.length,
                          itemBuilder:
                              (_, i) => ProjectTile(project: projects[i]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
