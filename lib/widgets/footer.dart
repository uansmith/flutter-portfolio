import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 700;

        return Container(
          width: double.infinity,
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🟢 Title (always centered)
              const Text(
                "Let's Build Something Great Together",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),

              // 🟢 Desktop or Mobile version switch
              if (isMobile)
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      children: [
                        _footerLink(
                          'Upwork',
                          'https://www.upwork.com/freelancers/~01a99efcccd9f191a5?mp_source=share',
                        ),
                        _footerLink('GitHub', 'https://github.com/uansmith'),
                        _footerLink('Email', 'mailto:rfadhilah86@gmail.com'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '© 2025 Ridwan Fadhilah | Built with Flutter',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Links
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      children: [
                        _footerLink(
                          'Upwork',
                          'https://www.upwork.com/freelancers/~01a99efcccd9f191a5?mp_source=share',
                        ),
                        _footerLink('GitHub', 'https://github.com/uansmith'),
                        _footerLink('Email', 'mailto:rfadhilah86@gmail.com'),
                      ],
                    ),
                    const SizedBox(width: 30),
                    // Divider line
                    Container(
                      height: 16,
                      width: 2,
                      color: Colors.white30,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    // Copyright
                    const Text(
                      '© 2025 Ridwan Fadhilah | Built with Flutter',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  static Widget _footerLink(String name, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
