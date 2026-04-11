import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'backend/app_backend.dart';
import 'backend/form_validators.dart';
import 'models/admin_submissions.dart';
import 'models/contact_message.dart';
import 'models/volunteer_application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBackend.initialize();
  runApp(const MyTrendingWebApp());
}

class MyTrendingWebApp extends StatelessWidget {
  const MyTrendingWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ardaita Unity and Development Association',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: const Color(0xFF2E7D32), // Dark Green
          surface: const Color(0xFFFFFFF0), // Ivory White
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFF0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
          displayMedium: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 18, height: 1.6),
        ),
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  int? _aboutUsSubTab;
  int? _resourcesSubTab;
  int? _volunteerSubTab;

  List<Widget> get _pages => [
    HomePage(
      onNavigate: (index, [subTab]) {
        setState(() {
          _selectedIndex = index;
          if (index == 4) _volunteerSubTab = subTab;
        });
      },
    ),
    AboutUsPage(initialSubTab: _aboutUsSubTab),
    const ProjectsPage(),
    ResourcesWrapper(initialSubTab: _resourcesSubTab),
    VolunteerWrapper(initialSubTab: _volunteerSubTab),
    const ContactUsPage(),
    const DonatePage(),
    const AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ardaita',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        actions: [
          _buildTopMenuItem(0, 'Home'),
          _buildAboutUsMenu(),
          _buildTopMenuItem(2, 'Initiatives'),
          _buildResourcesMenu(),
          _buildVolunteerMenu(),
          _buildTopMenuItem(5, 'Contact Us'),
          _buildTopMenuItem(6, 'Donate'),
          _buildTopMenuItem(7, 'Admin'),
          const SizedBox(width: 20),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[_selectedIndex],
      ),
    );
  }

  Widget _buildTopMenuItem(int index, String label) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () => setState(() => _selectedIndex = index),
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.green.shade100,
          backgroundColor: isSelected
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildAboutUsMenu() {
    final isSelected = _selectedIndex == 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<int?>(
        onSelected: (value) {
          setState(() {
            _selectedIndex = 1;
            _aboutUsSubTab = value;
          });
        },
        itemBuilder: (context) => const [
          PopupMenuItem<int?>(value: null, child: Text('About Us')),
          PopupMenuItem<int?>(value: 0, child: Text('Who We Are')),
          PopupMenuItem<int?>(value: 1, child: Text('What We Do')),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade100,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: isSelected ? Colors.white : Colors.green.shade100,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourcesMenu() {
    final isSelected = _selectedIndex == 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<int?>(
        onSelected: (value) {
          setState(() {
            _selectedIndex = 3;
            _resourcesSubTab = value;
          });
        },
        itemBuilder: (context) => const [
          PopupMenuItem<int?>(value: null, child: Text('Resources')),
          PopupMenuItem<int?>(value: 0, child: Text('Documents')),
          PopupMenuItem<int?>(value: 1, child: Text('Gallery')),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Resources',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade100,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: isSelected ? Colors.white : Colors.green.shade100,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolunteerMenu() {
    final isSelected = _selectedIndex == 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<int?>(
        onSelected: (value) {
          setState(() {
            _selectedIndex = 4;
            _volunteerSubTab = value;
          });
        },
        itemBuilder: (context) => const [
          PopupMenuItem<int?>(value: null, child: Text('Volunteer')),
          PopupMenuItem<int?>(value: 0, child: Text('Become a Volunteer')),
          PopupMenuItem<int?>(value: 1, child: Text('Our Volunteers')),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Volunteer',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade100,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: isSelected ? Colors.white : Colors.green.shade100,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourcesWrapper extends StatefulWidget {
  final int? initialSubTab;
  const ResourcesWrapper({super.key, this.initialSubTab});

  @override
  State<ResourcesWrapper> createState() => _ResourcesWrapperState();
}

class _ResourcesWrapperState extends State<ResourcesWrapper> {
  int? selectedSubTab;

  @override
  void initState() {
    super.initState();
    selectedSubTab = widget.initialSubTab;
  }

  @override
  void didUpdateWidget(ResourcesWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSubTab != oldWidget.initialSubTab) {
      selectedSubTab = widget.initialSubTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/Main_Page.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.35),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: selectedSubTab == null
                  ? const Center(
                      child: Text(
                        'Select a resource section to view details',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.93),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selectedSubTab == 0
                            ? const ResourcesPage()
                            : const GalleryPage(),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class VolunteerWrapper extends StatefulWidget {
  final int? initialSubTab;
  const VolunteerWrapper({super.key, this.initialSubTab});

  @override
  State<VolunteerWrapper> createState() => _VolunteerWrapperState();
}

class _VolunteerWrapperState extends State<VolunteerWrapper> {
  int? selectedSubTab;

  @override
  void initState() {
    super.initState();
    selectedSubTab = widget.initialSubTab;
  }

  @override
  void didUpdateWidget(VolunteerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSubTab != oldWidget.initialSubTab) {
      selectedSubTab = widget.initialSubTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/Main_Page.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.35),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: selectedSubTab == null
                  ? const Center(
                      child: Text(
                        'Select a section to start volunteering',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.93),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selectedSubTab == 0
                            ? const BecomeVolunteerPage()
                            : const VolunteersListPage(),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(int, [int?]) onNavigate;
  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Main_Page.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Empowering Ardaita Together',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Unity, Development, and Sustainable Growth for our Community',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () => onNavigate(2), // Initiatives
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 20,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Explore Initiatives'),
                            ),
                            OutlinedButton(
                              onPressed: () =>
                                  onNavigate(4, 0), // Become a Volunteer
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 20,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Become a Volunteer'),
                            ),
                            OutlinedButton(
                              onPressed: () => onNavigate(6), // Donate
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 20,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Support Ardaita'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Features/Stats Summary
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            child: Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                _buildStatItem(
                  context,
                  Icons.people,
                  '1000+',
                  'Lives Impacted',
                ),
                _buildStatItem(
                  context,
                  Icons.school,
                  '20+',
                  'Education Programs',
                ),
                _buildStatItem(context, Icons.eco, '100+', 'Green Initiatives'),
                _buildStatItem(
                  context,
                  Icons.trending_up,
                  '24/7',
                  'Community Support',
                ),
              ],
            ),
          ),

          // Short About Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Who We Are',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 24),
                const MaxWidthContainer(
                  child: Text(
                    'Ardaita Unity and Development Association is a community-driven organization dedicated to fostering sustainable progress, equitable education, and accessible healthcare in the Ardaita region.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, height: 1.6),
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => onNavigate(1),
                  child: const Text(
                    'Read our full story →',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Call to Action Bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            decoration: BoxDecoration(color: Colors.green.shade50),
            child: Column(
              children: [
                const Text(
                  'Join us in making a difference',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => onNavigate(5), // Contact
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'Get Involved Today',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            color: Colors.green.shade900,
            width: double.infinity,
            child: const Column(
              children: [
                Text(
                  '© 2026 Ardaita Unity and Development Association. All rights reserved.',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  'Ardaita, Ethiopia | info@ardaitaunity.org',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, size: 48, color: Colors.green.shade700),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = 800,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  final int? initialSubTab;

  const AboutUsPage({super.key, this.initialSubTab});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int? selectedSubTab; // null = nothing selected initially

  @override
  void initState() {
    super.initState();
    selectedSubTab = widget.initialSubTab;
  }

  @override
  void didUpdateWidget(covariant AboutUsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSubTab != widget.initialSubTab) {
      selectedSubTab = widget.initialSubTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/Main_Page.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.35),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            // Content area
            Expanded(
              child: selectedSubTab == null
                  ? const Center(
                      child: Text(
                        'Select a section to view details',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.93),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selectedSubTab == 0
                            ? const WhoWeAreTab()
                            : const WhatWeDoTab(),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class WhoWeAreTab extends StatelessWidget {
  const WhoWeAreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Organizational Structure',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 48),

          // Tree Structure
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildTreeLevel(
                    'Chairperson',
                    'Dejen Kuma(PhD)',
                    Icons.person_rounded,
                    isRoot: false,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 1032,
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 264,
                          top: 44,
                          child: _buildTreeLevel(
                            'Vice Chairperson',
                            'Yasin Tufa',
                            Icons.person_outline_rounded,
                            width: 230,
                          ),
                        ),
                        Positioned(
                          left: 516,
                          top: 0,
                          child: _buildVerticalLine(height: 230),
                        ),
                        Positioned(
                          left: 494,
                          top: 134,
                          child: Container(
                            width: 22,
                            height: 2,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 230,
                          child: Container(
                            width: 792,
                            height: 2,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 230,
                          child: _buildVerticalLine(height: 20),
                        ),
                        Positioned(
                          left: 384,
                          top: 230,
                          child: _buildVerticalLine(height: 20),
                        ),
                        Positioned(
                          left: 648,
                          top: 230,
                          child: _buildVerticalLine(height: 20),
                        ),
                        Positioned(
                          left: 912,
                          top: 230,
                          child: _buildVerticalLine(height: 20),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTreeBranchWithRightChild(
                        title: 'Operational and Admin Lead',
                        subtitle: 'Dr.Tefaye Megersa',
                        icon: Icons.admin_panel_settings_rounded,
                        childTitle: 'Operational Support',
                        childSubtitle: '',
                        childIcon: Icons.support_agent_rounded,
                        showChildDivider: false,
                        customChildContent: _buildIndividualBulletList([
                          'Bizuayehu Chala',
                          'Cheru Fano',
                        ]),
                      ),
                      const SizedBox(width: 24),
                      _buildTreeBranchWithRightChild(
                        title: 'Treasurer',
                        subtitle: 'Dereje Tilahun',
                        icon: Icons.account_balance_wallet_rounded,
                        childTitle: 'Treasurer Support',
                        childSubtitle: 'Faruk Teshale',
                        childIcon: Icons.payments_rounded,
                      ),
                      const SizedBox(width: 24),
                      _buildTreeBranchWithRightChild(
                        title: 'Secretary and PR lead',
                        subtitle: 'Abdulkadir Kaltiso',
                        icon: Icons.edit_note_rounded,
                        childTitle: 'Secretary and PR support',
                        childSubtitle: 'Beshir Edao',
                        childIcon: Icons.support_agent_rounded,
                      ),
                      const SizedBox(width: 24),
                      _buildTreeBranchWithRightChild(
                        title: 'Legal Lead',
                        subtitle: 'Habib Amano',
                        icon: Icons.gavel_rounded,
                        childTitle: 'Legal subcommittee',
                        childSubtitle: '',
                        childIcon: Icons.balance_rounded,
                        showChildDivider: false,
                        customChildContent: _buildIndividualBulletList([
                          'Asrat Abdo',
                          'Fitsum Husen',
                          'Mohammed Hayato',
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 64),
          Text(
            'Authority & Governance',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          const Text(
            'The NGO Establishment Committee (NEsCo) serves as a temporary, mandate-driven body entrusted by the General Assembly to lead and coordinate the establishment of the Association. Its primary role is to facilitate all preparatory processes required for legal registration and initial operational readiness, including drafting foundational documents, guiding consultative discussions, mobilizing membership, and ensuring compliance with applicable legal requirements. NEsCo exercises delegated authority to make timely decisions necessary for these purposes, within the scope defined by the General Assembly, and operates in a transparent and accountable manner. Its mandate concludes upon the formal establishment of the Association and the transition to the duly constituted governing body.',
            style: TextStyle(fontSize: 18, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualBulletList(List<String> names) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: names
          .map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTreeBranchWithRightChild({
    required String title,
    String subtitle = '',
    required IconData icon,
    required String childTitle,
    String childSubtitle = '',
    required IconData childIcon,
    bool showChildDivider = true,
    Widget? customChildContent,
  }) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          _buildTreeLevel(title, subtitle, icon, width: 230),
          SizedBox(
            width: 240,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(child: _buildVerticalLine(height: 50)),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
                  child: _buildTreeLevel(
                    childTitle,
                    childSubtitle,
                    childIcon,
                    width: 230,
                    height: null,
                    showCustomDivider: showChildDivider,
                    customContent: customChildContent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeLevel(
    String title,
    String subtitle,
    IconData icon, {
    bool isRoot = false,
    double width = 230,
    double? height = 180,
    String? imagePath,
    bool showCustomDivider = true,
    Widget? customContent,
  }) {
    return Container(
      width: width,
      height: height,
      constraints: height == null ? const BoxConstraints(minHeight: 180) : null,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isRoot ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E7D32), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePath != null
              ? CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(imagePath),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Icon(Icons.person_rounded, size: 32),
                )
              : Icon(
                  icon,
                  color: isRoot ? Colors.white : const Color(0xFF2E7D32),
                  size: 32,
                ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isRoot ? Colors.white : Colors.black87,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isRoot ? Colors.white70 : Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (customContent != null) ...[
            const SizedBox(height: 12),
            if (showCustomDivider)
              const Divider(height: 1, color: Colors.green),
            const SizedBox(height: 8),
            customContent,
          ],
        ],
      ),
    );
  }

  Widget _buildVerticalLine({double height = 40}) {
    return Container(height: height, width: 2, color: const Color(0xFF2E7D32));
  }
}

class WhatWeDoTab extends StatelessWidget {
  const WhatWeDoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vision', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          const Text(
            'To build a healthy, educated, environmentally sustainable, and economically empowered community where every individual has the opportunity to thrive with dignity and unity.',
            style: TextStyle(fontSize: 18, height: 1.6),
          ),
          const SizedBox(height: 40),
          Text('Mission', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          const Text(
            'Ardaita Unity and Development Association is a charitable organization committed to improving the quality of life in our community by:',
            style: TextStyle(fontSize: 18, height: 1.6),
          ),
          const SizedBox(height: 24),
          _buildListItem(
            'Promoting accessible and sustainable public health initiatives.',
            Icons.health_and_safety_outlined,
          ),
          _buildListItem(
            'Expanding equitable access to quality education and lifelong learning opportunities.',
            Icons.school_outlined,
          ),
          _buildListItem(
            'Protecting and restoring the environment through community-led conservation efforts.',
            Icons.eco_outlined,
          ),
          _buildListItem(
            'Supporting small-scale economic activities and entrepreneurship to enhance household income and self-reliance.',
            Icons.trending_up_outlined,
          ),
          const SizedBox(height: 40),
          Text('Core Values', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          _buildCoreValue(
            '1. Unity',
            'We believe collective effort and community collaboration are the foundation of sustainable development.',
          ),
          _buildCoreValue(
            '2. Integrity',
            'We operate with transparency, accountability, and ethical responsibility in all our actions.',
          ),
          _buildCoreValue(
            '3. Compassion',
            'We serve with empathy, prioritizing the needs of vulnerable and underserved populations.',
          ),
          _buildCoreValue(
            '4. Empowerment',
            'We strengthen individuals and families by building skills, knowledge, and economic opportunities.',
          ),
          _buildCoreValue(
            '5. Sustainability',
            'We promote environmentally responsible and long-term solutions that benefit future generations.',
          ),
          _buildCoreValue(
            '6. Equity and Inclusion',
            'We ensure equal opportunities regardless of gender, age, background, or economic status.',
          ),
          _buildCoreValue(
            '7. Innovation',
            'We embrace creative, practical, and locally driven approaches to solving community challenges.',
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoreValue(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 18, height: 1.6)),
        ],
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> initiatives = [
      {
        'title': 'Environment protection',
        'subtitle': 'Sustainability & Conservation',
        'icon': Icons.eco_rounded,
        'activities': [
          'Community reforestation projects',
          'Sustainable water resource management',
          'Environment awareness workshops',
          'Waste reduction initiatives',
        ],
      },
      {
        'title': 'Education',
        'subtitle': 'Learning & Development',
        'icon': Icons.school_rounded,
        'activities': [
          'Primary school support programs',
          'Vocational training for youth',
          'Digital literacy classes',
          'Educational resource distribution',
        ],
      },
      {
        'title': 'Health',
        'subtitle': 'Public Wellness & Safety',
        'icon': Icons.health_and_safety_rounded,
        'activities': [
          'Public health awareness campaigns',
          'Mental wellness support sessions',
          'Preventive care education',
          'Medical resource facilitation',
        ],
      },
      {
        'title': 'Economic activities',
        'subtitle': 'Growth & Empowerment',
        'icon': Icons.trending_up_rounded,
        'activities': [
          'Micro-finance group support',
          'Small business mentorship',
          'Entrepreneurship training',
          'Agricultural development support',
        ],
      },
      {
        'title': 'Social Care',
        'subtitle': 'Care for Vulnerable children & elderly',
        'icon': Icons.volunteer_activism_rounded,
        'activities': [
          'Protect Children & Elderly',
          'Support At-Risk Children',
          'Assist Vulnerable Elderly',
        ],
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Initiatives',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              mainAxisExtent: 320,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: initiatives.length,
            itemBuilder: (context, index) {
              final item = initiatives[index];
              return Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.green.shade100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              item['icon'],
                              color: Colors.green,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item['subtitle'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Core Activities:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (item['activities'] as List).length,
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item['activities'][i],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  static const List<Map<String, String>> _resources = [
    {
      'name': 'Ardaita_Amharic.pdf',
      'assetPath': 'assets/Ardaita_Amharic.pdf',
      'description': 'Official community development document in Amharic',
    },
    {
      'name': 'Ardaayita _ Afaan_Oromo.docx',
      'assetPath': 'assets/Ardaayita _ Afaan_Oromo.docx',
      'description': 'Community development document in Afaan Oromo',
    },
    {
      'name': 'Ardaita _ English Vesrion.docx',
      'assetPath': 'assets/Ardaita _ English Vesrion.docx',
      'description': 'Community development document in English',
    },
    {
      'name': 'Members_Mapping_ and_Registration_Form_04Feb26.xlsx',
      'assetPath': 'assets/Members_Mapping_ and_Registration_Form_04Feb26.xlsx',
      'description': 'Member mapping and registration spreadsheet',
    },
  ];

  Future<void> _openResource(BuildContext context, String assetPath) async {
    final resourceUri = Uri.base.resolve(assetPath);
    final opened = await launchUrl(resourceUri, webOnlyWindowName: '_blank');

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the selected resource.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
            child: Text(
              'Documents',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              itemCount: _resources.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final resource = _resources[index];
                final fileName = resource['name']!;
                final assetPath = resource['assetPath']!;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF2E7D32),
                    child: Icon(Icons.description, color: Colors.white),
                  ),
                  title: Text(
                    fileName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(resource['description']!),
                  trailing: const Icon(
                    Icons.download_rounded,
                    color: Colors.green,
                  ),
                  onTap: () => _openResource(context, assetPath),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = List.generate(
      10,
      (index) => 'assets/Ardaita.jpg',
    );

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Visuals',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.green.shade50,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                size: 40,
                                color: Colors.green.shade200,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Visual Capture ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  String? _feedbackMessage;
  bool _submissionSucceeded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _feedbackMessage = null;
    });

    try {
      final result = await AppBackend.formSubmissionService.submitContact(
        ContactMessage(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _submissionSucceeded = true;
        _feedbackMessage = result.message;
      });

      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _submissionSucceeded = false;
        _feedbackMessage = _formatError(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final backendConfigured = AppBackend.formSubmissionService.isConfigured;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Us', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactMethod(
                      Icons.location_on_rounded,
                      'Our Head Office',
                      'Addis Ababa, Ethiopia',
                    ),
                    const SizedBox(height: 24),
                    _buildContactMethod(
                      Icons.email_rounded,
                      'Email Us',
                      'info@ardaitaunity.org',
                    ),
                    const SizedBox(height: 24),
                    _buildContactMethod(
                      Icons.phone_rounded,
                      'Call Us',
                      '+251 911 000 000',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!backendConfigured) ...[
                        _buildFeedbackBanner(
                          'Live submissions are disabled in this build. Set API_BASE_URL or enable Firebase sync to receive messages.',
                          success: false,
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (_feedbackMessage != null) ...[
                        _buildFeedbackBanner(
                          _feedbackMessage!,
                          success: _submissionSucceeded,
                        ),
                        const SizedBox(height: 24),
                      ],
                      const Text(
                        'Send us a message',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => FormValidators.minLength(
                                value,
                                'Full name',
                                2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormValidators.email,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _messageController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Message',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => FormValidators.minLength(
                                value,
                                'Message',
                                10,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _isSubmitting ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                _isSubmitting
                                    ? 'Submitting...'
                                    : 'Submit Message',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackBanner(String message, {required bool success}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: success ? Colors.green.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: success ? Colors.green.shade900 : Colors.orange.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatError(Object error) {
    final message = error.toString();
    return message.startsWith('Bad state: ')
        ? message.substring('Bad state: '.length)
        : message;
  }

  Widget _buildContactMethod(IconData icon, String title, String detail) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 28),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              detail,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _tokenController = TextEditingController();
  final _limitController = TextEditingController(text: '25');

  bool _isLoading = false;
  bool _obscureToken = true;
  String? _feedbackMessage;
  AdminSubmissionsSnapshot? _snapshot;

  @override
  void dispose() {
    _tokenController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _loadSubmissions() async {
    final apiClient = AppBackend.restApiClient;
    final token = _tokenController.text.trim();
    final limit = int.tryParse(_limitController.text.trim()) ?? 25;

    if (apiClient == null) {
      setState(() {
        _feedbackMessage =
            'This build does not have an API configured. Set API_BASE_URL for admin access.';
      });
      return;
    }

    if (token.isEmpty) {
      setState(() {
        _feedbackMessage = 'Enter the admin token to view submissions.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _feedbackMessage = null;
    });

    try {
      final snapshot = await apiClient.fetchAdminSubmissions(token, limit: limit);
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _snapshot = snapshot;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _feedbackMessage = _formatError(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiBaseUrl = AppBackend.configuration.apiBaseUrl;
    final hasApi = apiBaseUrl.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admin', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          Text(
            'Use an admin token to read protected contact and volunteer submissions from the backend.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Backend connection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  hasApi
                      ? 'Connected to: $apiBaseUrl'
                      : 'No API base URL is configured in this build.',
                  style: TextStyle(
                    color: hasApi ? Colors.black87 : Colors.orange.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: 360,
                      child: TextField(
                        controller: _tokenController,
                        obscureText: _obscureToken,
                        decoration: InputDecoration(
                          labelText: 'Admin token',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureToken = !_obscureToken;
                              });
                            },
                            icon: Icon(
                              _obscureToken
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _limitController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Limit',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _loadSubmissions,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                      ),
                      icon: Icon(
                        _isLoading ? Icons.sync_rounded : Icons.download_rounded,
                      ),
                      label: Text(
                        _isLoading ? 'Loading...' : 'Load submissions',
                      ),
                    ),
                  ],
                ),
                if (_feedbackMessage != null) ...[
                  const SizedBox(height: 16),
                  _buildBanner(_feedbackMessage!, success: false),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (_snapshot != null) ...[
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildMetricCard(
                  'Contact messages',
                  _snapshot!.contact.total.toString(),
                  Icons.mail_outline_rounded,
                ),
                _buildMetricCard(
                  'Volunteer applications',
                  _snapshot!.volunteer.total.toString(),
                  Icons.volunteer_activism_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSubmissionSection(
              title: 'Latest contact messages',
              collection: _snapshot!.contact,
              emptyState: 'No contact messages were found.',
            ),
            const SizedBox(height: 24),
            _buildSubmissionSection(
              title: 'Latest volunteer applications',
              collection: _snapshot!.volunteer,
              emptyState: 'No volunteer applications were found.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade50,
            foregroundColor: const Color(0xFF2E7D32),
            child: Icon(icon),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionSection({
    required String title,
    required SubmissionCollection collection,
    required String emptyState,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Showing up to ${collection.limit} records out of ${collection.total}.',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          if (collection.items.isEmpty)
            Text(emptyState, style: const TextStyle(color: Colors.black54))
          else
            ...collection.items.map(_buildSubmissionCard),
        ],
      ),
    );
  }

  Widget _buildSubmissionCard(SubmissionItem item) {
    final details = <String>[
      if ((item.message ?? '').isNotEmpty) item.message!,
      if ((item.initiative ?? '').isNotEmpty) 'Initiative: ${item.initiative}',
      if ((item.motivation ?? '').isNotEmpty) item.motivation!,
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.shade50.withOpacity(0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                _formatDate(item.createdAt),
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SelectableText(
            item.email,
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...details.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(detail, style: const TextStyle(height: 1.5)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBanner(String message, {required bool success}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: success ? Colors.green.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: success ? Colors.green.shade900 : Colors.orange.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }

    final local = parsed.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.year}-$month-$day $hour:$minute';
  }

  String _formatError(Object error) {
    final message = error.toString();
    return message.startsWith('Bad state: ')
        ? message.substring('Bad state: '.length)
        : message;
  }
}

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_rounded, color: Colors.red, size: 80),
          const SizedBox(height: 24),
          Text(
            'Support Our Cause',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          const Text(
            'Until the website integration is complete, please make your donation to the following account:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: const Column(
              children: [
                Text(
                  'Account Name: Ardaita Unity and Development Association',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'CBE: 1000758051367',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Your generous donation helps us continue our mission to empower the Ardaita community through education, health, and sustainable development.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, height: 1.6),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildDonationCard(
                context,
                '\$1',
                'Provides school supplies for one student',
              ),
              _buildDonationCard(
                context,
                '\$5',
                'Supports a local community health workshop',
              ),
              _buildDonationCard(
                context,
                '\$10',
                'Funds a small-scale conservation project',
              ),
              _buildDonationCard(
                context,
                'Custom',
                'Any amount makes a significant difference',
              ),
            ],
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Donate Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(
    BuildContext context,
    String amount,
    String description,
  ) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class BecomeVolunteerPage extends StatefulWidget {
  const BecomeVolunteerPage({super.key});

  @override
  State<BecomeVolunteerPage> createState() => _BecomeVolunteerPageState();
}

class _BecomeVolunteerPageState extends State<BecomeVolunteerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _motivationController = TextEditingController();
  String? selectedInitiative;
  bool _isSubmitting = false;
  String? _feedbackMessage;
  bool _submissionSucceeded = false;
  final List<String> initiatives = [
    'Environment protection',
    'Education',
    'Health',
    'Economic activities',
    'Social Care',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    if (selectedInitiative == null || selectedInitiative!.trim().isEmpty) {
      setState(() {
        _submissionSucceeded = false;
        _feedbackMessage = 'Please choose an initiative before submitting.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _feedbackMessage = null;
    });

    try {
      final result = await AppBackend.formSubmissionService.submitVolunteer(
        VolunteerApplication(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          initiative: selectedInitiative!.trim(),
          motivation: _motivationController.text.trim(),
        ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _submissionSucceeded = true;
        _feedbackMessage = result.message;
        selectedInitiative = null;
      });

      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _motivationController.clear();
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _submissionSucceeded = false;
        _feedbackMessage = _formatError(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final backendConfigured = AppBackend.formSubmissionService.isConfigured;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Become a Volunteer',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!backendConfigured) ...[
                  _buildFeedbackBanner(
                    'Live submissions are disabled in this build. Set API_BASE_URL or enable Firebase sync to receive volunteer applications.',
                    success: false,
                  ),
                  const SizedBox(height: 24),
                ],
                if (_feedbackMessage != null) ...[
                  _buildFeedbackBanner(
                    _feedbackMessage!,
                    success: _submissionSucceeded,
                  ),
                  const SizedBox(height: 24),
                ],
                const Text(
                  'Join our community of change-makers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            FormValidators.minLength(value, 'Full name', 2),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormValidators.email,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Choose Initiative',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: selectedInitiative,
                        items: initiatives.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) =>
                            FormValidators.requiredField(value, 'Initiative'),
                        onChanged: (newValue) {
                          setState(() {
                            selectedInitiative = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _motivationController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Tell us why you want to join',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            FormValidators.minLength(value, 'Motivation', 10),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          _isSubmitting
                              ? 'Submitting...'
                              : 'Submit Application',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackBanner(String message, {required bool success}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: success ? Colors.green.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: success ? Colors.green.shade900 : Colors.orange.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatError(Object error) {
    final message = error.toString();
    return message.startsWith('Bad state: ')
        ? message.substring('Bad state: '.length)
        : message;
  }
}

class VolunteersListPage extends StatelessWidget {
  const VolunteersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockVolunteers = [
      {'name': 'Chalachew Kuma', 'initiative': 'Education', 'role': 'Teacher'},
      {
        'name': 'Fikru H/Mariam',
        'initiative': 'Enviroment Protection',
        'role': 'Enviromental Activist',
      },
      {
        'name': 'Haregot Kelay',
        'initiative': 'Social Care',
        'role': 'Youth Mentor',
      },
      {
        'name': 'Mekete Kuma',
        'initiative': 'Economic Activities',
        'role': 'Community Outreach',
      },
      {
        'name': 'Eyob Diriba',
        'initiative': 'Health',
        'role': 'Medical Advisor',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Volunteers',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.green.shade50),
              columns: const [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Initiative',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: mockVolunteers.map((volunteer) {
                return DataRow(
                  cells: [
                    DataCell(Text(volunteer['name']!)),
                    DataCell(Text(volunteer['initiative']!)),
                    DataCell(Text(volunteer['role']!)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
