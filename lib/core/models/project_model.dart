import 'package:flutter/material.dart';

enum ProjectCategory {
  all,
  ios,
  flutter,
  enterprise,
  ai,
  school,
  inventory,
}

extension ProjectCategoryExt on ProjectCategory {
  String get label {
    switch (this) {
      case ProjectCategory.all:
        return 'All';
      case ProjectCategory.ios:
        return 'iOS';
      case ProjectCategory.flutter:
        return 'Flutter';
      case ProjectCategory.enterprise:
        return 'Enterprise';
      case ProjectCategory.ai:
        return 'AI';
      case ProjectCategory.school:
        return 'School';
      case ProjectCategory.inventory:
        return 'Inventory';
    }
  }
}

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final List<String> features;
  final List<String> technologies;
  final List<ProjectCategory> categories;
  final String role;
  final Color accentColor;
  final IconData icon;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? appStoreUrl;
  final bool isFeatured;
  final String gradientStart;
  final String gradientEnd;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.features,
    required this.technologies,
    required this.categories,
    required this.role,
    required this.accentColor,
    required this.icon,
    this.githubUrl,
    this.liveDemoUrl,
    this.appStoreUrl,
    this.isFeatured = false,
    required this.gradientStart,
    required this.gradientEnd,
  });
}
