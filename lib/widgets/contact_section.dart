import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Define a custom color palette for elegance and professionalism
const Color _primaryColor = Color(0xFF007A9A); // Deep Teal/Cyan for branding
const Color _backgroundColor = Color(
  0xFFFDFDFD,
); // Near-white for clean contrast
const Color _upworkColor = Color(0xFF14A800); // Upwork brand green

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Private reusable button widget to encapsulate styling logic
  Widget _buildContactButton({
    required String label,
    required String url,
    required bool isPrimary,
    IconData? icon,
    Widget? customIcon,
  }) {
    // Style for the primary button (Solid fill, elevated)
    final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8, // Increased elevation for a 'pop' effect
      shadowColor: _primaryColor.withAlpha(200),
    );

    // Style for secondary buttons (Outlined, subtle)
    final ButtonStyle secondaryStyle = OutlinedButton.styleFrom(
      foregroundColor: _primaryColor,
      side: const BorderSide(
        color: Colors.black12,
        width: 1.5,
      ), // Subtle border
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    final Widget iconWidget =
        customIcon ??
        Icon(icon, color: isPrimary ? Colors.white : _primaryColor);

    if (isPrimary) {
      return ElevatedButton.icon(
        icon: iconWidget,
        label: Text(label),
        onPressed: () => _launchUrl(url),
        style: primaryStyle,
      );
    } else {
      return OutlinedButton.icon(
        icon: iconWidget,
        label: Text(label),
        onPressed: () => _launchUrl(url),
        style: secondaryStyle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Elegant, Impactful Title
          const Text(
            "Ready to Build Something Great?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          // Engaging Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const Text(
              "Let's connect and transform your ideas into exceptional mobile or web applications. Find me on your preferred platform below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Contact Buttons - using a slightly larger spacing
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 20,
            children: [
              // 1. Email (Primary CTA - Solid, attention-grabbing)
              _buildContactButton(
                label: "Email Me Directly",
                icon: Icons.email_rounded,
                url:
                    'mailto:rfadhilah86@gmail.com?subject=Collaboration%20Inquiry',
                isPrimary: true,
              ),

              // 2. LinkedIn (Secondary CTA - Outlined, professional)
              _buildContactButton(
                label: "Connect on LinkedIn",
                customIcon: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  size: 20,
                  color: _primaryColor,
                ),
                url: 'https://www.linkedin.com/in/ridwanfadh',
                isPrimary: false,
              ),

              // 3. Upwork (Secondary CTA - Outlined, using brand color for the icon)
              _buildContactButton(
                label: "Hire on Upwork",
                customIcon: const FaIcon(
                  FontAwesomeIcons.upwork,
                  color: _upworkColor, // Use brand color for the icon
                  size: 20,
                ),
                url:
                    'https://www.upwork.com/freelancers/~01a99efcccd9f191a5?mp_source=share',
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Optional: A final, courteous closing statement
          const Text(
            "I respond to all inquiries within 24 hours.",
            style: TextStyle(fontSize: 15, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
