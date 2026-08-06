import 'package:flutter/material.dart';

enum CertificateStatus { achieved, inProgress, planned }

class CertificateModel {
  final String title;
  final String issuer;
  final String date;
  final String description;
  final CertificateStatus status;
  final Color color;
  final IconData icon;
  final String? credentialUrl;

  const CertificateModel({
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    required this.status,
    required this.color,
    required this.icon,
    this.credentialUrl,
  });
}
