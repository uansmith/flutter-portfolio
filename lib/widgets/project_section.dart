import 'package:vector_math/vector_math_64.dart' as vmath;
import 'package:flutter/material.dart';
import '../pages/project_detail.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        "name": "Memento",
        "description":
            "All-in-one productivity app for finance, habits, journaling and mindfulness.",
        "tech": "Flutter, Hive database",
        "image": "assets/images/memento.png",
        "link": "#",
      },
      {
        "name": "Larsup App",
        "description":
            "Organisation management app for handling members and official correspondence.",
        "tech": "Flutter, Supabase, Google Cloud Console",
        "image": "assets/images/larsup.png",
        "link": "#",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
      ).copyWith(top: 20, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: projects
                .map(
                  (p) => ProjectCard(
                    name: p['name']!,
                    description: p['description']!,
                    tech: p['tech']!,
                    image: p['image']!,
                    link: p['link']!,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String name;
  final String description;
  final String tech;
  final String image;
  final String link;

  const ProjectCard({
    super.key,
    required this.name,
    required this.description,
    required this.tech,
    required this.image,
    required this.link,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  final larsupScreens = [
    'assets/images/Larsup1.jpg',
    'assets/images/Larsup2.jpg',
    'assets/images/Larsup3.jpg',
    'assets/images/Larsup4.jpg',
    'assets/images/Larsup5.jpg',
    'assets/images/Larsup6.jpg',
    'assets/images/Larsup7.jpg',
    'assets/images/Larsup9.jpg',
    'assets/images/Larsup10.jpg',
    'assets/images/Larsup11.jpg',
    'assets/images/Larsup12.jpg',
    'assets/images/Larsup13.jpg',
    'assets/images/Larsup14.jpg',
    'assets/images/Larsup15.jpg',
    'assets/images/Larsup16.jpg',
  ];

  final mementoScreens = [
    'assets/images/Memento1.jpg',
    'assets/images/Memento2.jpg',
    'assets/images/Memento3.jpg',
    'assets/images/Memento4.jpg',
    'assets/images/Memento5.jpg',
    'assets/images/Memento6.jpg',
    'assets/images/Memento7.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? Colors.blueAccent.withAlpha(50)
                  : Colors.black12,
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: _hovered ? Colors.blueAccent : Colors.transparent,
            width: 1.2,
          ),
        ),
        transform: _hovered
            ? vmath.Matrix4.translationValues(0, -8, 0)
            : vmath.Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                widget.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tech: ${widget.tech}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextButton(
                    onPressed: () {
                      final screenshots = widget.name == 'Larsup App'
                          ? larsupScreens
                          : widget.name == 'Memento'
                          ? mementoScreens
                          : <String>[];

                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: ProjectDetailPage(
                                      title: widget.name,
                                      description: widget.description,
                                      image: widget.image,
                                      tech: widget.tech,
                                      screenshots: screenshots,
                                    ),
                                  ),
                        ),
                      );
                    },
                    child: const Text("View Project →"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
