import 'package:flutter/material.dart';

enum SkillCategory {
  language,
  framework,
  tool,
  platform,
  database,
}

extension SkillCategoryExt on SkillCategory {
  String get label {
    switch (this) {
      case SkillCategory.language:
        return 'Languages';
      case SkillCategory.framework:
        return 'Frameworks & Libraries';
      case SkillCategory.tool:
        return 'Tools & DevOps';
      case SkillCategory.platform:
        return 'Platforms';
      case SkillCategory.database:
        return 'Data & Backend';
    }
  }
}

class SkillModel {
  final String name;
  final SkillCategory category;
  final double proficiency; // 0.0 – 1.0
  final IconData icon;
  final Color color;
  final String description;

  const SkillModel({
    required this.name,
    required this.category,
    required this.proficiency,
    required this.icon,
    required this.color,
    required this.description,
  });
}
