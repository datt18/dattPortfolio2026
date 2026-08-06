class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> responsibilities;
  final List<String> technologies;
  final bool isCurrent;
  final String location;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.responsibilities,
    required this.technologies,
    this.isCurrent = false,
    required this.location,
  });
}
