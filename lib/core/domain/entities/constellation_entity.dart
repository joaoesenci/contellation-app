import 'package:flutter/widgets.dart';

class ConstellationEntity {
  final String id;
  final String name;
  final String description;
  final String firstExample;
  final String secondExample;
  final IconData icon;

  const ConstellationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.firstExample,
    required this.secondExample,
    required this.icon,
  });
}
