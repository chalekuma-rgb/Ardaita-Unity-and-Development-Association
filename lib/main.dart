import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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

  List<Widget> get _pages => [
    HomePage(onNavigate: (index) => setState(() => _selectedIndex = index)),
    AboutUsPage(initialSubTab: _aboutUsSubTab),
    const ProjectsPage(),
    const ResourcesPage(),
    const GalleryPage(),
    const ContactUsPage(),
    const DonatePage(),
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
          _buildTopMenuItem(3, 'Resources'),
          _buildTopMenuItem(4, 'Gallery'),
          _buildTopMenuItem(5, 'Contact Us'),
          _buildTopMenuItem(6, 'Donate'),
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
              ? Colors.white.withValues(alpha: 0.1)
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
                ? Colors.white.withValues(alpha: 0.1)
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
}

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;
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
                    image: AssetImage('assets/Ardaita2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => onNavigate(2), // Initiatives
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green.shade900,
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
                            const SizedBox(width: 20),
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
          child: Image.asset('assets/Ardaita2.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.55),
                  Colors.black.withValues(alpha: 0.35),
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
                        color: Colors.white.withValues(alpha: 0.93),
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
                        childTitle: 'Operational Support Team',
                        childMembers: const ['Bizuayehu Chala', 'Cheru Fano'],
                        childIcon: Icons.support_agent_rounded,
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
                        childTitle: 'Legal Subcommittee',
                        childMembers: const [
                          'Asrat Abdo',
                          'Fitsum Husen',
                          'Mohammed Hayato',
                        ],
                        childIcon: Icons.balance_rounded,
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

  Widget _buildTreeBranch({
    required String title,
    String subtitle = '',
    required IconData icon,
  }) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          const SizedBox(height: 0),
          _buildTreeLevel(title, subtitle, icon, width: 230),
        ],
      ),
    );
  }

  Widget _buildTreeBranchWithRightChild({
    required String title,
    String subtitle = '',
    required IconData icon,
    required String childTitle,
    String childSubtitle = '',
    List<String>? childMembers,
    required IconData childIcon,
  }) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          const SizedBox(height: 0),
          _buildTreeLevel(title, subtitle, icon, width: 230),
          Column(
            children: [
              _buildVerticalLine(height: 50),
              _buildTreeLevel(
                childTitle,
                childSubtitle,
                childIcon,
                width: 230,
                height: childMembers == null ? 180 : null,
                content: childMembers == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildMemberList(childMembers),
                      ),
              ),
            ],
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
    Widget? content,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isRoot ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E7D32), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
          if (content != null) content,
        ],
      ),
    );
  }

  Widget _buildMemberList(List<String> members) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final member in members)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 8),
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: Colors.green.shade700,
                  ),
                ),
                Expanded(
                  child: Text(member, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
      ],
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

  IconData _iconForFile(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    }
    if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
      return Icons.description;
    }
    if (fileName.endsWith('.xls') || fileName.endsWith('.xlsx')) {
      return Icons.table_chart;
    }
    return Icons.insert_drive_file;
  }

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
              'Resources',
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
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF2E7D32),
                    child: Icon(_iconForFile(fileName), color: Colors.white),
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
                                  Colors.black.withValues(alpha: 0.6),
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

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const Text(
                        'Send us a message',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Submit Message'),
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
                  'CBE: 1000XXXXXXXXXXXXX',
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
            color: Colors.black.withValues(alpha: 0.05),
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
