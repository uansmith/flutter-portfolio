import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      alignment: Alignment.topCenter,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 700;

                if (isMobile) {
                  // ✅ Mobile layout — stacked vertically, no Expanded
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I build clean, responsive, and high-performance apps for mobile and web using Flutter."
                        " Focus on delivering professional-quality projects, with attention to UI, UX, and maintainable code.\n\n"
                        "Available for freelance work and ready to contribute to your project immediately.",
                        style: TextStyle(fontSize: 18, height: 1.6),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withAlpha(200),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  );
                } else {
                  // ✅ Desktop/tablet layout — side-by-side with Expanded
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "I build clean, responsive, and high-performance apps for mobile and web using Flutter."
                              " Focus on delivering professional-quality projects, with attention to UI, UX, and maintainable code.\n\n"
                              "Available for freelance work and ready to contribute to your project immediately.",
                              style: TextStyle(fontSize: 18, height: 1.6),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withAlpha(200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
