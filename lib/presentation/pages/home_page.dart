import 'package:flutter/material.dart';

import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/home_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/services_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isMobile, isTablet),
      body: ListView(
        controller: _scrollController,
        children: [
          HomeSection(),
          AboutSection(),
          ServicesSection(),
          ProjectsSection(),
          ContactSection(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isMobile, bool isTablet) {
    return AppBar(
      elevation: _isScrolled ? 10 : 0,
      backgroundColor: _isScrolled
          ? Colors.white.withValues(alpha: 0.95)
          : Colors.black,
      surfaceTintColor: Colors.transparent,
      title: _buildLogo(isMobile, isTablet),
      actions: _buildActions(isMobile, isTablet),
      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  Widget _buildLogo(bool isMobile, bool isTablet) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.construction,
            color: Colors.white,
            size: isMobile ? 20 : 24,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'JORPI',
          style: TextStyle(
            fontSize: isMobile ? 18 : (isTablet ? 20 : 22),
            fontWeight: FontWeight.bold,
            color: _isScrolled
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            letterSpacing: 2,
          ),
        ),
        Text(
          ' CONSTRUCTORA',
          style: TextStyle(
            fontSize: isMobile ? 12 : (isTablet ? 14 : 16),
            fontWeight: FontWeight.w300,
            color: _isScrolled
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.8),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions(bool isMobile, bool isTablet) {
    if (isMobile) {
      return [
        IconButton(
          onPressed: () {
            _showMobileMenu(context);
          },
          icon: Icon(
            Icons.menu,
            color: _isScrolled
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
          ),
        ),
      ];
    }

    return [
      _buildNavItem('Inicio', () => _scrollToSection(0)),
      _buildNavItem('Nosotros', () => _scrollToSection(1)),
      _buildNavItem('Servicios', () => _scrollToSection(2)),
      _buildNavItem('Proyectos', () => _scrollToSection(3)),
      _buildNavItem('Contacto', () => _scrollToSection(4)),
      const SizedBox(width: 20),
      _buildContactButton(isTablet),
    ];
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: _isScrolled
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildContactButton(bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _scrollToSection(4),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'Contáctanos',
          style: TextStyle(
            fontSize: isTablet ? 12 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFlexibleSpace() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isScrolled
              ? [Colors.transparent, Colors.transparent]
              : [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildMobileMenuItem('Inicio', Icons.home, () {
              Navigator.pop(context);
              _scrollToSection(0);
            }),
            _buildMobileMenuItem('Nosotros', Icons.people, () {
              Navigator.pop(context);
              _scrollToSection(1);
            }),
            _buildMobileMenuItem('Servicios', Icons.build, () {
              Navigator.pop(context);
              _scrollToSection(2);
            }),
            _buildMobileMenuItem('Proyectos', Icons.work, () {
              Navigator.pop(context);
              _scrollToSection(3);
            }),
            _buildMobileMenuItem('Contacto', Icons.contact_phone, () {
              Navigator.pop(context);
              _scrollToSection(4);
            }),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _scrollToSection(4);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Contáctanos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  void _scrollToSection(int sectionIndex) {
    final sections = [
      0.0, // Home
      800.0, // About
      1600.0, // Services
      2900.0, // Projects
      3800.0, // Contact
    ];

    if (sectionIndex < sections.length) {
      _scrollController.animateTo(
        sections[sectionIndex],
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
