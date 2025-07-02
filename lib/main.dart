import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jorpi_sac/core/theme/app_theme.dart';
import 'package:jorpi_sac/domain/usecases/get_projects.dart';
import 'package:jorpi_sac/presentation/pages/home_page.dart';

import 'core/di/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => di.sl<GetProjects>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jorpi Constructora',
        theme: AppTheme.themeData,
        home: const HomePage(),
      ),
    );
  }
}
