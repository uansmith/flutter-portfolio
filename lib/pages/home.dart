import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/project_section.dart';
import '../widgets/footer.dart';
import '../widgets/section_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Track current active section
  String currentSection = '';

  bool _showBackToTopButton = false;

  // Section keys
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _scrollListener() {
    const double scrollThreshold = 400.0;

    if (_scrollController.offset >= scrollThreshold) {
      if (!_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = true;
        });
      }
    } else {
      if (_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        elevation: 10,
        shadowColor: Colors.black26,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
        ),
        backgroundColor: Colors.white.withAlpha(200),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: Colors.black87,
                ),
                onPressed: () => Navigator.pop(context),
                tooltip: 'Close',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Text(
                'Navigation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const Divider(),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
                color: Colors.blueAccent,
              ),
              hoverColor: Colors.blueAccent.withAlpha(150),
              onTap: () {
                setState(() => currentSection = 'home');
                scrollToTop();
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                setState(() => currentSection = 'about');
                scrollToSection(aboutKey);
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              title: const Text(
                'Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                setState(() => currentSection = 'projects');
                scrollToSection(projectsKey);
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 4,
              ),
              title: const Text(
                'Contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                setState(() => currentSection = 'contact');
                scrollToSection(contactKey);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              mini: true,
              onPressed: scrollToTop,
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        const HeroSection(),
                        const SizedBox(height: 100),

                        // ABOUT
                        Padding(
                          key: aboutKey,
                          padding: const EdgeInsets.only(top: 80),
                          child: SectionTitle(title: 'About'),
                        ),
                        const AboutSection(),

                        // PROJECTS
                        Padding(
                          key: projectsKey,
                          padding: const EdgeInsets.only(top: 80),
                          child: SectionTitle(title: 'Projects'),
                        ),
                        const ProjectsSection(),

                        // CONTACT
                        Padding(
                          key: contactKey,
                          padding: const EdgeInsets.only(top: 80),
                          child: SectionTitle(title: 'Contact'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.white,
              child: NavBar(
                currentSection: currentSection,
                onHomeTap: () {
                  setState(() => currentSection = 'home');
                  scrollToTop();
                },
                onAboutTap: () {
                  setState(() => currentSection = 'about');
                  scrollToSection(aboutKey);
                },
                onProjectsTap: () {
                  setState(() => currentSection = 'projects');
                  scrollToSection(projectsKey);
                },
                onContactTap: () {
                  setState(() => currentSection = 'contact');
                  scrollToSection(contactKey);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
