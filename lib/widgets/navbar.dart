import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavBar extends StatelessWidget {
  final String currentSection;
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const NavBar({
    super.key,
    this.onHomeTap,
    this.onAboutTap,
    this.onProjectsTap,
    this.onContactTap,
    required this.currentSection,
  });

  static const double _kDesktopBreakpoint = 600.0;

  Widget _navButton(String section, String text, VoidCallback? onTap) {
    final bool isSelected = currentSection == section;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        minimumSize: const Size(80, double.infinity),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blueAccent : Colors.white,
        ),
      ),
    );
  }

  Widget _navTitle() {
    return const Text(
      "FlutterDev",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > _kDesktopBreakpoint) {
              // --- DESKTOP VIEW ---
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navTitle(),
                  Row(
                    children: [
                      _navButton('home', "Home", onHomeTap),
                      _navButton('about', "About", onAboutTap),
                      _navButton('projects', "Projects", onProjectsTap),
                      _navButton('contact', "Contact", onContactTap),
                    ],
                  ),
                ],
              );
            } else {
              // --- MOBILE VIEW ---
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navTitle(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withAlpha(200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        LucideIcons.menu,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
