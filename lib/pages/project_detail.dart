import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProjectDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String tech;
  final List<String> screenshots;

  const ProjectDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.tech,
    required this.screenshots,
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  // 1. Controller for the CarouselSlider
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // 💡 State variable for controlling auto-play (default to true)
  bool _isAutoPlaying = true;

  late final List<String> captions;
  late AnimationController _animController;
  late Animation<Offset> _leftSlide;
  late Animation<Offset> _rightSlide;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _leftSlide = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _rightSlide = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();

    // captions
    if (widget.title == 'Larsup App') {
      captions = [
        'Displays the client\'s logo prominently upon app launch. Its purpose is to deliver instant branding and engage the user visually while the application data loads in the background, ensuring a smooth transition to the main flow.',
        'This screen provides the essential and secure access point to the application, prioritizing user convenience through multiple authentication pathways. Users can log in traditionally using their Username and Password, which is securely managed and integrated with Supabase, or opt for a frictionless experience with direct Google and Apple single sign-on (SSO) options. A key feature is the "Kintun Serat Tanpa Login" button, offering a unique capability for unregistered users to send a message immediately, while the "Hilap Sandi" link is readily available to facilitate smooth password recovery, ensuring accessibility for all user states.',
        'Dashboard Overview — Displays username and profile at the top-right. Below is the Announcement widget, currently showing “Teu acan aya bewara” (“No announcements”). Only higher roles such as admins can create or delete announcements through the Administrator Panel. Eight functional buttons remain below for quick access.',
        'Edit Profile — Accessible by tapping the profile on the dashboard. The form includes username, email, phone number, university, branch, birth date, and password. Certain fields appear greyed out — editable only by higher roles for security and data integrity.',
        'Incoming Mail — Accessed from the dashboard, this screen lists all received correspondence. Features include batch delete and mark-as-read actions, individual controls via the three-dot menu, and an add button at the bottom-right for new entries.',
        'Outgoing Mail — Similar to the incoming mail view, this screen manages all sent correspondence with identical batch and individual action features for efficiency.',
        'Add Mail — Opens when tapping the add button. The form includes fields for name, date, and subject. Users can also upload a file (Unggah file), restricted to PDF format for standardisation and security.',
        'About Page — Provides an overview of the application and its purpose. Includes Sundanese language support as specifically requested by the client.',
        'Administrator Panel — Exclusive to users with administrator privileges. Features include member management, member requests, announcement creation, and activity audits for full organisational control.',
        'Branch List — Allows admins to add, edit, or delete branches. Users without an assigned branch appear under “Anggota Tanpa Cabang” (Members Without Branch), where admins can reassign them to the appropriate branch.',
        'Admin panel',
        'Branch Detail — Displays information about a specific branch. Admins can add new members using the add button located at the bottom-right corner.',
        'Add Member Form — Appears after tapping the add button in Branch Detail. The form includes fields for name, email, password, role, username, university, phone number, and birth date.',
        'Add Announcement — A pop-up form accessible from the Administrator Panel. It includes only title and content fields, automatically recording the creation date and the username of the announcer for display on the dashboard.',
        'Ngawengkong (General Chat) — A shared space where all members can communicate. Displays message timestamps and unread indicators. The three-dot menu at the top-right allows admins to clear the chat history.',
        'Edit Profile Picture — A section within the profile edit screen where users can update their photo. The image can be cropped or left as is before saving the change.',
      ];
    } else if (widget.title == 'Memento') {
      captions = [
        'Streamlined task management: quickly add and prioritize items by setting a name, due date, and priority level (Low-High). Sorting options include Custom, Due Date, or Priority Level.',
        'Permanent habit tracking: define and maintain long-term habits with dedicated, lasting cards. Users mark completion via a daily checklist button, which resets every 24 hours to collect continuous monthly progress data.',
        'Minimalist meditation timer: initiate sessions with a single tap. Users can select favorite ambient sounds or utilize a random shuffle feature, which is accompanied by a customizable session timer .',
        'Comprehensive daily finance tracking for income and expenses. The system features an automated 50/30/20 budget allocator (Needs, Wants, Savings), offering both auto-separation and manual categorization. Includes a Scheduled Payments widget that automatically integrates due dates as tasks on the To-do List screen.',
        'Digital journaling interface presenting entries in a 3x3 card grid for effortless browsing. New journals are saved as individual cards, which expand upon selection to display the full title and written content.',
        'Streamlined Task Entry: The n/Addn/ pop-up facilitates quick task creation, requiring only a Task Name, a clear Priority Level (Low, Medium, High), and a selectable Due Date. This ensures rapid input and classification.',
        'Minimalist Settings interface for essential personalization. Features include options to manage Language preferences, select the desired Currency format, and view detailed About information for the application.',
      ];
    } else {
      captions = [];
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 26,
            ),
            tooltip: 'Back to Projects',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;

          final horizontalPadding = isMobile ? 24.0 : 60.0;
          final verticalPadding = isMobile ? 30.0 : 60.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCarousel(height: 420),
                            const SizedBox(height: 24),
                            _buildDescription(isMobile: true),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: SlideTransition(
                                position: _leftSlide,
                                child: _buildCarousel(height: 500),
                              ),
                            ),
                            const VerticalDivider(
                              width: 40,
                              thickness: 0.6,
                              color: Colors.grey,
                            ),
                            Expanded(
                              flex: 1,
                              child: SlideTransition(
                                position: _rightSlide,
                                child: _buildDescription(),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarousel({required double height}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 🖼️ The carousel itself
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withAlpha(200),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CarouselSlider(
            // 2. Assign the controller to the CarouselSlider
            carouselController: _carouselController,
            options: CarouselOptions(
              height: height,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              // 💡 USE STATE: Bind autoPlay to the state variable
              autoPlay: _isAutoPlaying,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1.0,
              aspectRatio: 9 / 18,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.screenshots.map((imgPath) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imgPath, fit: BoxFit.cover),
              );
            }).toList(),
          ),
        ),

        // ⬅️ Left button
        Positioned(
          left: 12,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 28),
            color: Colors.white,
            onPressed: () {
              // Stop auto-play temporarily when manually scrolling
              if (_isAutoPlaying) {
                _carouselController.stopAutoPlay();
                // Set to false, and let the user decide to resume
                setState(() => _isAutoPlaying = false);
              }
              _carouselController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.black.withAlpha(10),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(1),
            ),
          ),
        ),

        // ➡️ Right button
        Positioned(
          right: 12,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 28),
            color: Colors.white,
            onPressed: () {
              // Stop auto-play temporarily when manually scrolling
              if (_isAutoPlaying) {
                _carouselController.stopAutoPlay();
                // Set to false, and let the user decide to resume
                setState(() => _isAutoPlaying = false);
              }
              _carouselController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.black.withAlpha(10),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription({bool isMobile = false}) {
    return Padding(
      padding: EdgeInsets.only(top: isMobile ? 8 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 💡 UPDATED: Pause/Play Button (Now visible on Mobile and Desktop)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextButton.icon(
              // Use different icons/colors based on current state
              icon: Icon(
                _isAutoPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_fill_rounded,
                color: _isAutoPlaying ? Colors.redAccent : Colors.green,
                size: 24,
              ),
              label: Text(
                _isAutoPlaying ? 'Pause Slideshow' : 'Resume Slideshow',
                style: TextStyle(
                  color: _isAutoPlaying ? Colors.redAccent : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  // Toggle the state
                  _isAutoPlaying = !_isAutoPlaying;
                });
                // Also manually call stop/start for immediate effect
                if (_isAutoPlaying) {
                  _carouselController.startAutoPlay();
                } else {
                  _carouselController.stopAutoPlay();
                }
              },
            ),
          ),

          Text(
            'Screen ${_currentIndex + 1} of ${widget.screenshots.length}',
            style: TextStyle(
              fontSize: isMobile ? 12.5 : 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              captions.isNotEmpty ? captions[_currentIndex] : '',
              style: TextStyle(
                fontSize: isMobile ? 14.5 : 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              textStyle: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('← Back to Projects'),
          ),
        ],
      ),
    );
  }
}
