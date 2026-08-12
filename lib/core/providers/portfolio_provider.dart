import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';
import '../models/certificate_model.dart';
import '../constants/app_colors.dart';

// ── Project Filter Provider ────────────────────────────────────────────────
final selectedCategoryProvider =
    StateProvider<ProjectCategory>((ref) => ProjectCategory.all);

final filteredProjectsProvider = Provider<List<ProjectModel>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  final projects = ref.watch(projectsProvider);
  if (category == ProjectCategory.all) return projects;
  return projects
      .where((p) => p.categories.contains(category))
      .toList();
});

// ── Data Providers ─────────────────────────────────────────────────────────
final projectsProvider = Provider<List<ProjectModel>>((ref) => _projects);
final skillsProvider = Provider<List<SkillModel>>((ref) => _skills);
final experiencesProvider = Provider<List<ExperienceModel>>((ref) => _experiences);
final certificatesProvider = Provider<List<CertificateModel>>((ref) => _certificates);

// ══════════════════════════════════════════════════════════════════════════
// DATA
// ══════════════════════════════════════════════════════════════════════════

// ── Projects ──────────────────────────────────────────────────────────────
final List<ProjectModel> _projects = [
  ProjectModel(
    id: 'event_management',
    title: 'Enterprise Event Management',
    shortDescription:
        'Conference & trade show apps for global events with 10K+ attendees.',
    description:
        'Developed enterprise event applications used for conferences, exhibitions, '
        'trade shows, and networking events worldwide. Built for scale, offline use, '
        'and real-time collaboration — powering sessions, exhibitor maps, and live polls.',
    features: [
      'Agenda & Session Management',
      'Speaker Profiles',
      'Exhibitor & Product Listings',
      'Interactive Maps (Mapbox)',
      'Attendee Networking',
      'Live Polls & Surveys',
      'Offline Mode (SQLite sync)',
      'QR Code Check-in',
      'Push Notifications',
      'Real-time Chat (Socket.IO)',
    ],
    technologies: [
      'Swift', 'Objective-C', 'Flutter', 'UIKit', 'SQLite',
      'Firebase', 'REST APIs', 'Mapbox', 'Socket.IO', 'SPM',
    ],
    categories: [
      ProjectCategory.ios,
      ProjectCategory.flutter,
      ProjectCategory.enterprise,
    ],
    role: 'Lead Mobile Developer',
    accentColor: AppColors.appleBlue,
    icon: Icons.event,
    isFeatured: true,
    gradientStart: '#007AFF',
    gradientEnd: '#0056B3',
  ),
  ProjectModel(
    id: 'ai_agents',
    title: 'AI Agents Platform',
    shortDescription:
        'Intelligent AI-powered apps using LLMs for automation and document analysis.',
    description:
        'Built AI-powered applications using modern Large Language Models and '
        'intelligent automation. Engineered prompt pipelines, document analysis '
        'workflows, and AI search capabilities for enterprise productivity.',
    features: [
      'AI Chat Interface',
      'Document Analysis (PDF/Docs)',
      'Prompt Engineering',
      'Workflow Automation',
      'AI-powered Search',
      'Content Generation',
      'Multi-model Support',
      'Conversation History',
    ],
    technologies: [
      'Flutter', 'OpenAI API', 'Claude API', 'Firebase', 'REST APIs', 'Dart',
    ],
    categories: [ProjectCategory.flutter, ProjectCategory.ai],
    role: 'Flutter Developer & AI Integration',
    accentColor: AppColors.applePurple,
    icon: Icons.psychology,
    isFeatured: true,
    gradientStart: '#AF52DE',
    gradientEnd: '#7B2FBE',
  ),
  ProjectModel(
    id: 'school_management',
    title: 'School Management System',
    shortDescription:
        'Complete school ERP covering attendance, results, timetable & parent portal.',
    description:
        'Developed comprehensive school management systems used by educational '
        'institutions to streamline operations from attendance tracking to fee '
        'management and parent communication.',
    features: [
      'Attendance Tracking',
      'Homework Assignment',
      'Results & Report Cards',
      'Student Profiles',
      'Push Notifications',
      'Timetable Management',
      'Fee Management',
      'Parent Portal',
      'Teacher Dashboard',
    ],
    technologies: [
      'Flutter', 'Swift', 'SQLite', 'Firebase', 'REST APIs',
    ],
    categories: [ProjectCategory.flutter, ProjectCategory.ios, ProjectCategory.school],
    role: 'Mobile Developer',
    accentColor: AppColors.appleGreen,
    icon: Icons.school,
    isFeatured: true,
    gradientStart: '#34C759',
    gradientEnd: '#248A3D',
  ),
  ProjectModel(
    id: 'stock_management',
    title: 'Stock & Inventory Management',
    shortDescription:
        'Warehouse & inventory system with barcode scanning and offline sync.',
    description:
        'Developed inventory and warehouse management systems enabling businesses '
        'to track stock, scan barcodes, generate reports, and sync data offline — '
        'reducing inventory errors by over 80%.',
    features: [
      'Inventory Tracking',
      'Barcode Scanner',
      'Reports & Analytics',
      'Sales Management',
      'Purchase Orders',
      'Offline Sync',
      'Stock Alerts',
      'Supplier Management',
      'Export to Excel/PDF',
    ],
    technologies: [
      'Flutter', 'Swift', 'SQLite', 'Firebase', 'REST APIs',
    ],
    categories: [ProjectCategory.flutter, ProjectCategory.ios, ProjectCategory.inventory],
    role: 'Mobile Developer',
    accentColor: AppColors.appleOrange,
    icon: Icons.inventory_2,
    isFeatured: false,
    gradientStart: '#FF9F0A',
    gradientEnd: '#C93400',
  ),
];

// ── Skills ─────────────────────────────────────────────────────────────────
final List<SkillModel> _skills = [
  // Languages
  SkillModel(
    name: 'Swift',
    category: SkillCategory.language,
    proficiency: 0.95,
    icon: Icons.apple,
    color: AppColors.appleOrange,
    description: 'Primary iOS development language',
  ),
  SkillModel(
    name: 'Dart',
    category: SkillCategory.language,
    proficiency: 0.90,
    icon: Icons.flutter_dash,
    color: AppColors.appleBlue,
    description: 'Flutter & Dart development',
  ),
  SkillModel(
    name: 'Objective-C',
    category: SkillCategory.language,
    proficiency: 0.80,
    icon: Icons.code,
    color: AppColors.appleBlue,
    description: 'Legacy iOS codebase maintenance',
  ),
  // Frameworks
  SkillModel(
    name: 'SwiftUI',
    category: SkillCategory.framework,
    proficiency: 0.90,
    icon: Icons.layers,
    color: AppColors.appleBlue,
    description: 'Declarative Apple UI framework',
  ),
  SkillModel(
    name: 'UIKit',
    category: SkillCategory.framework,
    proficiency: 0.92,
    icon: Icons.smartphone,
    color: AppColors.appleBlue,
    description: 'Core iOS UI framework',
  ),
  SkillModel(
    name: 'Flutter',
    category: SkillCategory.framework,
    proficiency: 0.90,
    icon: Icons.flutter_dash,
    color: const Color(0xFF54C5F8),
    description: 'Cross-platform mobile & web',
  ),
  SkillModel(
    name: 'Firebase',
    category: SkillCategory.framework,
    proficiency: 0.85,
    icon: Icons.local_fire_department,
    color: AppColors.appleOrange,
    description: 'Auth, Firestore, FCM',
  ),
  SkillModel(
    name: 'REST APIs',
    category: SkillCategory.framework,
    proficiency: 0.92,
    icon: Icons.api,
    color: AppColors.appleGreen,
    description: 'API integration & design',
  ),
  SkillModel(
    name: 'Socket.IO',
    category: SkillCategory.framework,
    proficiency: 0.78,
    icon: Icons.wifi,
    color: AppColors.applePurple,
    description: 'Real-time communication',
  ),
  SkillModel(
    name: 'Mapbox',
    category: SkillCategory.framework,
    proficiency: 0.80,
    icon: Icons.map,
    color: AppColors.appleGreen,
    description: 'Custom maps & navigation',
  ),
  // Data & Backend
  SkillModel(
    name: 'SQLite',
    category: SkillCategory.database,
    proficiency: 0.88,
    icon: Icons.storage,
    color: AppColors.appleBlue,
    description: 'Local offline data persistence',
  ),
  SkillModel(
    name: 'CoreData',
    category: SkillCategory.database,
    proficiency: 0.82,
    icon: Icons.data_object,
    color: AppColors.applePurple,
    description: 'Apple persistence framework',
  ),
  // Tools
  SkillModel(
    name: 'Xcode',
    category: SkillCategory.tool,
    proficiency: 0.95,
    icon: Icons.developer_mode,
    color: AppColors.appleBlue,
    description: 'Apple primary IDE',
  ),
  SkillModel(
    name: 'Git / GitHub',
    category: SkillCategory.tool,
    proficiency: 0.90,
    icon: Icons.merge_type,
    color: const Color(0xFFE34F26),
    description: 'Version control & collaboration',
  ),
  SkillModel(
    name: 'App Store Connect',
    category: SkillCategory.tool,
    proficiency: 0.88,
    icon: Icons.store,
    color: AppColors.appleBlue,
    description: 'App deployment & analytics',
  ),
  SkillModel(
    name: 'Android Studio',
    category: SkillCategory.tool,
    proficiency: 0.80,
    icon: Icons.android,
    color: AppColors.appleGreen,
    description: 'Flutter & Android development',
  ),
  SkillModel(
    name: 'SPM / CocoaPods',
    category: SkillCategory.tool,
    proficiency: 0.85,
    icon: Icons.extension,
    color: AppColors.appleOrange,
    description: 'Package & dependency management',
  ),
  SkillModel(
    name: 'Push Notifications',
    category: SkillCategory.platform,
    proficiency: 0.88,
    icon: Icons.notifications,
    color: AppColors.appleRed,
    description: 'APNs & FCM integration',
  ),
];

// ── Experience ────────────────────────────────────────────────────────────
final List<ExperienceModel> _experiences = [
  ExperienceModel(
    company: 'Elsner Technology LTD',
    role: 'iOS & Flutter Developer',
    duration: '2+ Years',
    startDate: 'June 2024',
    endDate: 'Present',
    isCurrent: true,
    location: 'Ahmedabad, India',
    description:
    'Developing and maintaining production-grade iOS and Flutter applications '
        'for enterprise clients across event management, education, AI, and inventory '
        'management domains. Responsible for mobile architecture, feature development, '
        'API integration, offline data management, third-party SDK integration, '
        'performance optimization, and App Store deployment.',
    responsibilities: [
      'Designed and developed production-ready iOS applications using Swift, SwiftUI, UIKit, and Objective-C',
      'Built cross-platform Flutter applications for iOS and Android',
      'Developed enterprise event management applications with modules for sessions, speakers, exhibitors, products, networking, surveys, and check-in',
      'Integrated REST APIs, Firebase, Socket.IO, Mapbox, and third-party SDKs',
      'Implemented offline-first functionality using SQLite with data synchronization',
      'Worked with Agentic AI concepts including AI agents, LLM integrations, prompt engineering, API-based AI workflows, and intelligent automation',
      'Implemented real-time features using socket-based communication',
      'Optimized application performance, API calls, database operations, and UI responsiveness',
      'Worked with CocoaPods and Swift Package Manager for dependency management',
      'Handled App Store Connect, provisioning, certificates, build configuration, and production releases',
      'Investigated and resolved production bugs, crashes, UI issues, and App Store submission problems',
      'Collaborated with backend developers, designers, QA engineers, and project managers to deliver production features',
    ],
    technologies: [
      'Swift',
      'Objective-C',
      'SwiftUI',
      'UIKit',
      'Flutter',
      'Dart',
      'Firebase',
      'SQLite',
      'REST APIs',
      'Socket.IO',
      'Mapbox',
      'Agentic AI',
      'LLM APIs',
      'CocoaPods',
      'Swift Package Manager',
      'Git',
      'Xcode',
      'App Store Connect',
    ],
  ),

  ExperienceModel(
    company: 'Elsner Technology LTD',
    role: 'iOS Intern',
    duration: '0.5+ Year',
    startDate: 'January 2024',
    endDate: 'June 2024',
    isCurrent: false,
    location: 'Ahmedabad, India',
    description:
    'Started my professional iOS development journey by contributing to '
        'production mobile applications and learning industry-standard development '
        'practices. Worked primarily with Swift, Objective-C, UIKit, APIs, SQLite, '
        'and third-party SDK integrations while collaborating with senior developers '
        'and the development team.',
    responsibilities: [
      'Developed and maintained iOS applications using Swift, Objective-C, and UIKit',
      'Implemented application screens and user interfaces based on UI/UX designs',
      'Worked with REST APIs to fetch, process, and display application data',
      'Maintained and enhanced existing Objective-C codebases',
      'Integrated third-party SDKs and libraries including Mapbox',
      'Worked with SQLite for local data storage and offline functionality',
      'Fixed UI issues, bugs, crashes, and application performance problems',
      'Learned iOS application architecture, debugging, memory management, and development best practices',
      'Collaborated with senior developers, designers, and QA engineers',
      'Participated in code reviews, testing, debugging, and application release activities',
    ],
    technologies: [
      'Swift',
      'Objective-C',
      'UIKit',
      'REST APIs',
      'SQLite',
      'Mapbox',
      'Xcode',
      'CocoaPods',
      'Git',
    ],
  ),
];

// ── Certificates ──────────────────────────────────────────────────────────
final List<CertificateModel> _certificates = [
  CertificateModel(
    title: 'Apple Developer Program',
    issuer: 'Apple Inc.',
    date: '2022',
    description:
        'Active Apple Developer Program member with experience publishing apps '
        'to the App Store and managing certificates, provisioning profiles.',
    status: CertificateStatus.achieved,
    color: AppColors.primaryText,
    icon: Icons.apple,
  ),
  CertificateModel(
    title: 'Flutter Development',
    issuer: 'Google / Dart',
    date: '2022',
    description:
        'Proficient in Flutter for cross-platform development with production '
        'apps deployed on iOS, Android, and Web.',
    status: CertificateStatus.achieved,
    color: const Color(0xFF54C5F8),
    icon: Icons.flutter_dash,
  ),
  CertificateModel(
    title: 'AWS Cloud Practitioner',
    issuer: 'Amazon Web Services',
    date: 'In Progress',
    description:
        'Currently studying for AWS Cloud Practitioner certification to strengthen '
        'cloud infrastructure knowledge.',
    status: CertificateStatus.inProgress,
    color: AppColors.appleOrange,
    icon: Icons.cloud,
  ),
  CertificateModel(
    title: 'iOS Development (Advanced)',
    issuer: 'Apple Inc.',
    date: 'Planned 2025',
    description:
        'Planning to pursue advanced Apple certification covering visionOS, '
        'SwiftUI advanced patterns, and Swift Concurrency.',
    status: CertificateStatus.planned,
    color: AppColors.appleBlue,
    icon: Icons.workspace_premium,
  ),
];
