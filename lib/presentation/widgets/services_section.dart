import 'package:flutter/material.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _staggerController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            index * 0.2,
            (index + 1) * 0.2,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    _fadeController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _staggerController.dispose();
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Theme.of(context).colorScheme.surface, Colors.white],
        ),
      ),
      child: Column(
        children: [
          // Section Header
          FadeTransition(
            opacity: _fadeController,
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
                    'NUESTROS SERVICIOS',
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
                  'Soluciones integrales',
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
                  'Ofrecemos servicios especializados para transformar tus ideas en realidades',
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
          // Services Grid
          isMobile
              ? _buildMobileServicesGrid(context)
              : _buildDesktopServicesGrid(context, isTablet),
          SizedBox(height: isMobile ? 40 : 60),
          // Call to Action
          FadeTransition(
            opacity: _fadeController,
            child: _buildCallToAction(context, isMobile, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileServicesGrid(BuildContext context) {
    return Column(
      children: [
        _buildServiceCard(
          context,
          0,
          Icons.home_work,
          'Construcción',
          'Construimos viviendas y edificios comerciales con los más altos estándares de calidad y seguridad.',
          'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Viviendas residenciales',
            'Edificios comerciales',
            'Obras industriales',
            'Infraestructura',
          ],
        ),
        const SizedBox(height: 20),
        _buildServiceCard(
          context,
          1,
          Icons.brush,
          'Remodelación',
          'Renovamos y mejoramos espacios existentes para darles nueva vida y funcionalidad.',
          'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Renovación de interiores',
            'Ampliaciones',
            'Mejoras estructurales',
            'Actualización de sistemas',
          ],
        ),
        const SizedBox(height: 20),
        _buildServiceCard(
          context,
          2,
          Icons.architecture,
          'Diseño de Planos',
          'Desarrollamos diseños arquitectónicos innovadores que optimizan el espacio y la funcionalidad.',
          'https://images.unsplash.com/photo-1504307651254-35680f356dfd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Planos arquitectónicos',
            'Diseño de interiores',
            'Planificación urbana',
            'Consultoría técnica',
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopServicesGrid(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceCard(
          context,
          0,
          Icons.home_work,
          'Construcción',
          'Construimos viviendas y edificios comerciales con los más altos estándares de calidad y seguridad.',
          'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Viviendas residenciales',
            'Edificios comerciales',
            'Obras industriales',
            'Infraestructura',
          ],
        ),
        _buildServiceCard(
          context,
          1,
          Icons.brush,
          'Remodelación',
          'Renovamos y mejoramos espacios existentes para darles nueva vida y funcionalidad.',
          'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Renovación de interiores',
            'Ampliaciones',
            'Mejoras estructurales',
            'Actualización de sistemas',
          ],
        ),
        _buildServiceCard(
          context,
          2,
          Icons.architecture,
          'Diseño de Planos',
          'Desarrollamos diseños arquitectónicos innovadores que optimizan el espacio y la funcionalidad.',
          'https://images.unsplash.com/photo-1504307651254-35680f356dfd?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          [
            'Planos arquitectónicos',
            'Diseño de interiores',
            'Planificación urbana',
            'Consultoría técnica',
          ],
        ),
      ],
    );
  }

  Widget _buildCallToAction(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 25 : (isTablet ? 30 : 40)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileCallToAction(context)
          : _buildDesktopCallToAction(context, isTablet),
    );
  }

  Widget _buildMobileCallToAction(BuildContext context) {
    return Column(
      children: [
        const Text(
          '¿Listo para comenzar tu proyecto?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Contáctanos para una consulta gratuita y descubre cómo podemos hacer realidad tu visión.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to contact
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Solicitar Cotización',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopCallToAction(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Listo para comenzar tu proyecto?',
                style: TextStyle(
                  fontSize: isTablet ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Contáctanos para una consulta gratuita y descubre cómo podemos hacer realidad tu visión.',
                style: TextStyle(
                  fontSize: isTablet ? 14 : 16,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isTablet ? 20 : 30),
        ElevatedButton(
          onPressed: () {
            // Navigate to contact
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 25 : 30,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Solicitar Cotización',
            style: TextStyle(
              fontSize: isTablet ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    int index,
    IconData icon,
    String title,
    String description,
    String imageUrl,
    List<String> features,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return AnimatedBuilder(
      animation: _cardAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _cardAnimations[index].value)),
          child: Opacity(
            opacity: _cardAnimations[index].value,
            child: Container(
              width: isMobile ? double.infinity : (isTablet ? 280 : 350),
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
                  // Image header
                  Container(
                    height: isMobile ? 180 : (isTablet ? 200 : 250),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(isMobile ? 12 : 15),
                          padding: EdgeInsets.all(isMobile ? 10 : 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            size: isMobile ? 20 : 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: EdgeInsets.all(
                      isMobile ? 20 : (isTablet ? 22 : 25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isMobile ? 20 : (isTablet ? 22 : 24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 12 : 15),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 25),
                        // Features list
                        ...features.map(
                          (feature) => Padding(
                            padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: isMobile ? 14 : 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                SizedBox(width: isMobile ? 8 : 10),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 25),
                        // Learn more button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to service details
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 10 : 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Saber más',
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
