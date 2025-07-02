import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60.0 : 80.0,
        horizontal: isMobile ? 20.0 : (isTablet ? 40.0 : 60.0),
      ),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : 20,
                    vertical: isMobile ? 6 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'SOBRE NOSOTROS',
                    style: TextStyle(
                      fontSize: isMobile ? 10 : 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: isMobile ? 1 : 2,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                Text(
                  'Construyendo el futuro',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                Container(
                  width: isMobile ? 60 : 80,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          // Main Content
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context, isTablet),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Image first on mobile
        FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://images.unsplash.com/photo-1581092918056-0c7c13e47213?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Text content
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildFeatureCard(
                  context,
                  Icons.engineering,
                  'Experiencia Profesional',
                  'Más de 15 años de experiencia en el sector de la construcción, con un equipo altamente calificado.',
                ),
                const SizedBox(height: 20),
                _buildFeatureCard(
                  context,
                  Icons.verified,
                  'Calidad Garantizada',
                  'Cada proyecto se ejecuta bajo los más altos estándares de calidad y seguridad.',
                ),
                const SizedBox(height: 20),
                _buildFeatureCard(
                  context,
                  Icons.trending_up,
                  'Innovación Constante',
                  'Utilizamos las últimas tecnologías y materiales para garantizar resultados excepcionales.',
                ),
                const SizedBox(height: 30),
                _buildStatsCard(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      children: [
        // Text Content
        Expanded(
          flex: 1,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureCard(
                    context,
                    Icons.engineering,
                    'Experiencia Profesional',
                    'Más de 15 años de experiencia en el sector de la construcción, con un equipo altamente calificado.',
                  ),
                  SizedBox(height: isTablet ? 20 : 30),
                  _buildFeatureCard(
                    context,
                    Icons.verified,
                    'Calidad Garantizada',
                    'Cada proyecto se ejecuta bajo los más altos estándares de calidad y seguridad.',
                  ),
                  SizedBox(height: isTablet ? 20 : 30),
                  _buildFeatureCard(
                    context,
                    Icons.trending_up,
                    'Innovación Constante',
                    'Utilizamos las últimas tecnologías y materiales para garantizar resultados excepcionales.',
                  ),
                  SizedBox(height: isTablet ? 30 : 40),
                  _buildStatsCard(context),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: isTablet ? 40 : 60),
        // Image Content
        Expanded(
          flex: 1,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                Container(
                  height: isTablet ? 400 : 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1581092918056-0c7c13e47213?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Floating stats card
                Positioned(
                  bottom: 30,
                  right: -20,
                  child: Container(
                    padding: EdgeInsets.all(isTablet ? 15 : 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          '15+',
                          style: TextStyle(
                            fontSize: isTablet ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          'Años de\nExperiencia',
                          style: TextStyle(
                            fontSize: isTablet ? 10 : 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : (isTablet ? 18 : 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 10 : 12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: isMobile ? 20 : 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: isMobile ? 15 : 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : (isTablet ? 17 : 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : (isTablet ? 20 : 25)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.construction,
            size: isMobile ? 30 : (isTablet ? 35 : 40),
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: isMobile ? 15 : 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Proyectos Completados',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : (isTablet ? 17 : 18),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: isMobile ? 3 : 5),
                Text(
                  'Más de 200 proyectos exitosos',
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
