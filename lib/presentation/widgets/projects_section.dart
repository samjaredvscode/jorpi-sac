import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jorpi_sac/presentation/bloc/projects_bloc.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
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

    return BlocProvider(
      create: (context) =>
          ProjectsBloc(getProjects: context.read())..add(FetchProjects()),
      child: Container(
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
                      ).colorScheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'NUESTROS PROYECTOS',
                      style: TextStyle(
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                        letterSpacing: isMobile ? 1 : 2,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 15 : 20),
                  Text(
                    'Portafolio de obras',
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
                  SizedBox(height: isMobile ? 15 : 20),
                  Text(
                    'Descubre algunos de nuestros proyectos más destacados',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: isMobile ? 40 : 60),
            // Projects Content
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: BlocBuilder<ProjectsBloc, ProjectsState>(
                  builder: (context, state) {
                    if (state is ProjectsLoading) {
                      return SizedBox(
                        height: isMobile ? 300 : 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Cargando proyectos...',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is ProjectsLoaded) {
                      return Column(
                        children: [
                          // Projects Grid
                          isMobile
                              ? _buildMobileProjectsGrid(
                                  context,
                                  state.projects,
                                )
                              : _buildDesktopProjectsGrid(
                                  context,
                                  state.projects,
                                  isTablet,
                                ),
                          SizedBox(height: isMobile ? 30 : 40),
                          // View All Projects Button
                          _buildViewAllButton(context, isMobile, isTablet),
                        ],
                      );
                    } else if (state is ProjectsError) {
                      return SizedBox(
                        height: isMobile ? 300 : 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: isMobile ? 48 : 64,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: isMobile ? 15 : 20),
                              Text(
                                'Error al cargar proyectos',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 10),
                              Text(
                                state.message,
                                style: TextStyle(
                                  fontSize: isMobile ? 12 : 14,
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isMobile ? 15 : 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ProjectsBloc>().add(
                                    FetchProjects(),
                                  );
                                },
                                child: Text(
                                  'Reintentar',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileProjectsGrid(BuildContext context, List projects) {
    return Column(
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        return Column(
          children: [
            _buildProjectCard(context, project, index, true),
            if (index < projects.length - 1) const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDesktopProjectsGrid(
    BuildContext context,
    List projects,
    bool isTablet,
  ) {
    return SizedBox(
      height: isTablet ? 450 : 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Container(
            width: isTablet ? 320 : 400,
            margin: const EdgeInsets.only(right: 30),
            child: _buildProjectCard(context, project, index, false),
          );
        },
      ),
    );
  }

  Widget _buildViewAllButton(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to all projects page
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 30 : (isTablet ? 35 : 40),
            vertical: isMobile ? 14 : 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          'Ver Todos los Proyectos',
          style: TextStyle(
            fontSize: isMobile ? 14 : (isTablet ? 15 : 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    project,
    int index,
    bool isMobile,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          Container(
            height: isMobile ? 200 : (isTablet ? 220 : 250),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(project.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Project category badge
                  Positioned(
                    top: isMobile ? 15 : 20,
                    left: isMobile ? 15 : 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10 : 12,
                        vertical: isMobile ? 5 : 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Construcción',
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // View project button
                  Positioned(
                    bottom: isMobile ? 15 : 20,
                    right: isMobile ? 15 : 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Navigate to project details
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.primary,
                          size: isMobile ? 20 : 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Project Content
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : (isTablet ? 22 : 25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: TextStyle(
                    fontSize: isMobile ? 20 : (isTablet ? 22 : 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 15),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                // Project details
                Row(
                  children: [
                    _buildProjectDetail(
                      context,
                      Icons.calendar_today,
                      '2024',
                      isMobile,
                    ),
                    SizedBox(width: isMobile ? 15 : 20),
                    _buildProjectDetail(
                      context,
                      Icons.location_on,
                      'Lima, Perú',
                      isMobile,
                    ),
                    SizedBox(width: isMobile ? 15 : 20),
                    _buildProjectDetail(
                      context,
                      Icons.construction,
                      'Completado',
                      isMobile,
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 20 : 25),
                // Project features
                Wrap(
                  spacing: isMobile ? 6 : 8,
                  runSpacing: isMobile ? 6 : 8,
                  children: [
                    _buildFeatureChip('Residencial', isMobile),
                    _buildFeatureChip('Moderno', isMobile),
                    _buildFeatureChip('Sustentable', isMobile),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDetail(
    BuildContext context,
    IconData icon,
    String text,
    bool isMobile,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: isMobile ? 14 : 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: isMobile ? 4 : 5),
        Text(
          text,
          style: TextStyle(
            fontSize: isMobile ? 12 : 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(String label, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 12,
        vertical: isMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isMobile ? 10 : 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
